#!/bin/bash
# block-config-edits.sh — PreToolUse hook to block edits to critical config files
# Prevents accidental modification of CI/CD, lock files, infrastructure, and
# security-sensitive configuration files.
#
# How to customize: Edit the BLOCKED_PATTERNS array below. Each entry is a
# bash glob pattern matched against the file path. Use ** for directory
# wildcards and * for filename wildcards.
set -euo pipefail

# ┌──────────────────────────────────────────────────────────────────────┐
# │  BLOCKED FILE PATTERNS — edit this list to add/remove protections   │
# └──────────────────────────────────────────────────────────────────────┘
BLOCKED_PATTERNS=(
  # ── CI/CD Pipelines ──
  ".github/workflows/*"
  ".github/actions/*"
  ".gitlab-ci.yml"
  ".gitlab/*"
  "Jenkinsfile"
  ".circleci/*"
  ".travis.yml"
  "azure-pipelines.yml"
  "bitbucket-pipelines.yml"
  ".buildkite/*"
  "cloudbuild.yaml"
  ".drone.yml"
  ".woodpecker.yml"
  "appveyor.yml"

  # ── Code Ownership & Review ──
  "CODEOWNERS"
  ".github/CODEOWNERS"
  ".gitlab/CODEOWNERS"
  "docs/CODEOWNERS"

  # ── Package Manager Lock Files ──
  "package-lock.json"
  "yarn.lock"
  "pnpm-lock.yaml"
  "bun.lockb"
  "bun.lock"
  "Cargo.lock"
  "Pipfile.lock"
  "poetry.lock"
  "uv.lock"
  "go.sum"
  "Gemfile.lock"
  "composer.lock"
  "flake.lock"
  "pubspec.lock"
  "Package.resolved"
  "gradle.lockfile"

  # ── Infrastructure ──
  "Dockerfile"
  "Dockerfile.*"
  "docker-compose.yml"
  "docker-compose.yaml"
  "docker-compose.*.yml"
  "docker-compose.*.yaml"
  "compose.yml"
  "compose.yaml"
  "compose.*.yml"
  "compose.*.yaml"
  ".dockerignore"
  ".terraform.lock.hcl"
  "*.tfvars"
  "backend.tf"
  "providers.tf"
  "versions.tf"
  "terragrunt.hcl"
  "kustomization.yaml"
  "Chart.yaml"
  "values.yaml"
  "Procfile"

  # ── Git Config ──
  ".gitattributes"
  ".gitmodules"
  ".git-blame-ignore-revs"
  ".lfsconfig"
  ".mailmap"

  # ── Security & Quality Gates ──
  ".pre-commit-config.yaml"
  ".husky/*"
  "lefthook.yml"
  ".releaserc"
  ".releaserc.yml"
  ".releaserc.json"
  "renovate.json"
  ".renovaterc"
  "dependabot.yml"
  ".github/dependabot.yml"
  ".sops.yaml"
)

# ── Read hook input ──
input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Only check Write and Edit tools
if [[ "$tool_name" != "Write" && "$tool_name" != "Edit" ]]; then
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

# ── Check against blocked patterns ──
for pattern in "${BLOCKED_PATTERNS[@]}"; do
  # Use bash extended globbing for matching
  # Match relative path, basename, or as a suffix of the full path
  # shellcheck disable=SC2254
  if [[ "$rel_path" == $pattern ]] || [[ "$(basename "$rel_path")" == $pattern ]] || [[ "$file_path" == */"$pattern" ]] || [[ "$file_path" == */$pattern ]]; then
    cat >&2 <<EOF
{"hookSpecificOutput":{"permissionDecision":"deny"},"systemMessage":"BLOCKED: Editing '$rel_path' is not allowed. This file matches protected pattern '$pattern'. These files are critical configuration that should not be modified by AI agents without explicit user override. If the user insists, they can temporarily remove the pattern from block-config-edits.sh."}
EOF
    exit 2
  fi
done

exit 0
