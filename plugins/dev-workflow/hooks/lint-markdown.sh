#!/bin/bash
set -euo pipefail

# Read hook input from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Exit early if no file path or not a markdown file
if [[ -z "$file_path" ]] || [[ ! "$file_path" =~ \.md$ ]]; then
  exit 0
fi

# Exit early if file doesn't exist (might have been deleted)
if [[ ! -f "$file_path" ]]; then
  exit 0
fi

# Use npx to run markdownlint-cli2 (works with local or global install)
LINT_CMD="npx --yes markdownlint-cli2"

# Step 1: Auto-fix what can be fixed
$LINT_CMD --fix "$file_path" 2>/dev/null || true

# Step 2: Re-check for remaining issues
lint_output=$($LINT_CMD "$file_path" 2>&1) || lint_exit=$?

if [[ -n "${lint_exit:-}" ]] && [[ "$lint_exit" -ne 0 ]]; then
  # There are remaining issues - report them back to Claude
  cat <<EOF >&2
{
  "systemMessage": "Markdown lint errors remain after auto-fix in $file_path. Please fix these issues:\n\n$lint_output"
}
EOF
  exit 2
fi

# All good - file is clean
exit 0
