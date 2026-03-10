#!/bin/bash
# block-secret-reads.sh — PreToolUse hook to block reads of sensitive files
# Prevents AI agents from accessing files that contain secrets, API keys,
# credentials, private keys, and other sensitive data.
#
# How to customize: Edit the BLOCKED_PATTERNS and BLOCKED_EXTENSIONS arrays
# below. Patterns are matched against relative file paths; extensions are
# matched against file suffixes.
set -euo pipefail

# ┌──────────────────────────────────────────────────────────────────────┐
# │  BLOCKED FILE PATTERNS — edit this list to add/remove protections   │
# └──────────────────────────────────────────────────────────────────────┘
BLOCKED_PATTERNS=(
  # ── Environment Files ──
  ".env"
  ".env.*"
  ".env.local"
  ".env.development"
  ".env.staging"
  ".env.production"
  ".env.test"
  "*.env"
  ".flaskenv"
  ".envrc"

  # ── SSH Keys ──
  "id_rsa"
  "id_rsa.pub"
  "id_dsa"
  "id_ecdsa"
  "id_ed25519"
  "known_hosts"
  "authorized_keys"
  ".ssh/*"

  # ── AWS Credentials ──
  ".aws/credentials"
  ".aws/config"
  "aws-credentials.json"
  ".s3cfg"
  ".boto"

  # ── GCP Credentials ──
  "application_default_credentials.json"
  "service-account*.json"
  "*-sa-key.json"
  "gcloud-credentials.json"
  "google-cloud-credentials.json"
  "firebase-adminsdk-*.json"

  # ── Azure Credentials ──
  "accessTokens.json"
  "azureProfile.json"
  ".azure/credentials"
  "azure.auth"

  # ── Application Secrets ──
  "secrets.yml"
  "secrets.yaml"
  "secrets.json"
  "secrets.toml"
  "secret_token.rb"
  "master.key"
  "credentials.yml.enc"
  "credentials.json"
  "vault.yml"
  "vault.yaml"
  "vault.json"
  ".vault-token"
  "*.vault.yml"

  # ── Auth & Token Files ──
  ".npmrc"
  ".yarnrc"
  ".yarnrc.yml"
  ".pypirc"
  ".gem/credentials"
  ".dockercfg"
  ".docker/config.json"
  ".htpasswd"
  ".htaccess"
  ".netrc"
  "_netrc"
  ".git-credentials"
  ".github_token"
  ".gitlab_token"

  # ── OAuth & JWT ──
  "client_secret*.json"
  "oauth-credentials.json"
  "token.json"
  "token.pickle"
  "jwt.key"
  "jwt-secret.*"

  # ── Terraform State (contains plaintext secrets) ──
  "terraform.tfstate"
  "terraform.tfstate.backup"
  "*.tfvars"
  "*.auto.tfvars"
  ".terraformrc"
  "terraform.rc"

  # ── Kubernetes Secrets ──
  "kubeconfig"
  ".kube/config"

  # ── Database Credentials ──
  "database.yml"
  "database.yaml"
  "db-credentials.*"
  ".pgpass"
  "wp-config.php"

  # ── Mobile App Secrets ──
  "google-services.json"
  "GoogleService-Info.plist"

  # ── Password Databases ──
  "*.kdbx"
  "*.kdb"
  "*.psafe3"

  # ── IDE Credential Leaks ──
  ".idea/dataSources.xml"
  ".vscode/sftp.json"

  # ── Other Sensitive Files ──
  "*.keystore"
  "*.jks"
  "token"
  ".tokens"
  ".secret"
  ".sops.yaml"
  "age.key"
)

# ┌──────────────────────────────────────────────────────────────────────┐
# │  BLOCKED EXTENSIONS — files with these suffixes are always blocked  │
# └──────────────────────────────────────────────────────────────────────┘
BLOCKED_EXTENSIONS=(
  ".pem"
  ".key"
  ".pfx"
  ".p12"
  ".pkcs12"
  ".pgp"
  ".gpg"
  ".ppk"
  ".asc"
  ".cer"
  ".crt"
  ".der"
  ".p7b"
  ".keychain"
  ".keychain-db"
  ".pvk"
  ".snk"
  ".bks"
)

# ── Read hook input ──
input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.command // empty')

# For Bash tool, extract file paths from common read commands
if [[ "$tool_name" == "Bash" ]]; then
  command_str=$(echo "$input" | jq -r '.tool_input.command // empty')
  # Check if the bash command is reading a sensitive file (cat, head, tail, less, more, vim, nano)
  if [[ "$command_str" =~ (cat|head|tail|less|more|bat|vim|nano|code|view|strings)[[:space:]]+(.*) ]]; then
    file_path="${BASH_REMATCH[2]}"
    # Strip flags (words starting with -)
    file_path=$(echo "$file_path" | sed 's/ -[^ ]*//g' | xargs)
  else
    exit 0
  fi
fi

# Only check Read, Glob, Grep, and Bash tools
if [[ "$tool_name" != "Read" && "$tool_name" != "Glob" && "$tool_name" != "Grep" && "$tool_name" != "Bash" ]]; then
  exit 0
fi

if [[ -z "$file_path" ]]; then
  exit 0
fi

# Resolve to relative path from project root
if [[ -n "${CLAUDE_PROJECT_DIR:-}" ]]; then
  rel_path="${file_path#"$CLAUDE_PROJECT_DIR"/}"
else
  rel_path="$file_path"
fi

basename_file=$(basename "$rel_path")

# ── Check against blocked extensions ──
for ext in "${BLOCKED_EXTENSIONS[@]}"; do
  if [[ "$basename_file" == *"$ext" ]]; then
    cat >&2 <<EOF
{"hookSpecificOutput":{"permissionDecision":"deny"},"systemMessage":"BLOCKED: Reading '$rel_path' is not allowed. Files with extension '$ext' may contain private keys or certificates. These files should never be accessed by AI agents. If the user insists, they can temporarily remove the extension from block-secret-reads.sh."}
EOF
    exit 2
  fi
done

# ── Check against blocked patterns ──
for pattern in "${BLOCKED_PATTERNS[@]}"; do
  # shellcheck disable=SC2254
  if [[ "$rel_path" == $pattern ]] || [[ "$basename_file" == $pattern ]] || [[ "$rel_path" == */"$pattern" ]]; then
    cat >&2 <<EOF
{"hookSpecificOutput":{"permissionDecision":"deny"},"systemMessage":"BLOCKED: Reading '$rel_path' is not allowed. This file matches sensitive pattern '$pattern' and may contain secrets, API keys, or credentials. These files should never be accessed by AI agents. If the user insists, they can temporarily remove the pattern from block-secret-reads.sh."}
EOF
    exit 2
  fi
done

exit 0
