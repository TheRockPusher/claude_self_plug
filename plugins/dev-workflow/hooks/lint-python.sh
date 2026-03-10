#!/bin/bash
set -euo pipefail

# Read hook input from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Exit early if no file path or not a Python file
if [[ -z "$file_path" ]] || [[ ! "$file_path" =~ \.py$ ]]; then
  exit 0
fi

# Exit early if file doesn't exist (might have been deleted)
if [[ ! -f "$file_path" ]]; then
  exit 0
fi

# Step 1: Auto-format with ruff
ruff format "$file_path" 2>/dev/null || true

# Step 2: Auto-fix lint issues
ruff check --fix "$file_path" 2>/dev/null || true

# Step 3: Re-check for remaining lint issues
lint_output=$(ruff check "$file_path" 2>&1) || lint_exit=$?

if [[ -n "${lint_exit:-}" ]] && [[ "$lint_exit" -ne 0 ]]; then
  # Escape newlines for JSON
  escaped_output=$(echo "$lint_output" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')
  cat <<EOF >&2
{
  "systemMessage": "Ruff lint errors remain after auto-fix in $file_path. Please fix these issues:\n\n${escaped_output}"
}
EOF
  exit 2
fi

# All good - file is clean
exit 0
