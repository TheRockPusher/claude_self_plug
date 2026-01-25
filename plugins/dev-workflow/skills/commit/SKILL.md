---
name: commit
description: ALWAYS USE THIS SKILL when the user asks to "commit changes", "create a commit", "git commit", "/commit", or mentions wanting well-formatted commits. Creates atomic, conventional commits with emoji indicators through 6-phase workflow: discovery (git status/diff), analysis (determine commit type and scope), user confirmation, staging, commit creation, and verification.
argument-hint: [optional: files-to-commit]
allowed-tools: Bash(git*), Bash(jq*), AskUserQuestion
model: haiku
context: fork
---

# Commit

Create atomic, well-formatted git commits following conventional commit
standards with emoji indicators.

**Core Principle**: Analyse changes thoroughly, suggest logical groupings,
and create clean commit history.

## Process

### Phase 1: Review Current State

Run these commands to gather context:

- Status: !`git status`
- Staged diff: !`git diff --staged`
- Diff: !`git diff`
- Log: !`git log -5 --oneline`

### Phase 2: Validation

**Fail fast if:**

- No changes detected (staged or unstaged)
- Repository is in conflicted state
- Detached HEAD without user confirmation

### Phase 3: Staging Logic

- **If staged files exist** → commit ONLY those files
- **If arguments provided** → stage and commit ONLY specified files
- **If no staged files** → analyse all changes, ask which to stage
- **Never auto-stage everything** without user confirmation

### Phase 4: Change Analysis

Analyse the diff to identify:

- Logical groupings of changes
- Multiple change types (feat + fix, refactor + test)
- Different subsystems touched (database + API)
- Unrelated bug fixes in same diff

**Suggest splitting** into multiple commits when detecting:

- Multiple change types (feat + docs)
- Different subsystems touched
- Unrelated bug fixes
- Test changes for unrelated features

### Phase 5: Commit Creation

**Message Format:**

```text
<type>: <emoji> <description>
```

**Rules:**

- Keep first line under 72 characters
- Use imperative mood ("add" not "added" or "adds")
- Be concise and direct—no filler words
- **Never add signatures** like "Generated with Claude" or co-author tags

**For multi-line commits:**

```text
<type>(<scope>): <emoji> <short description>

<detailed explanation if needed>
```

### Phase 6: Confirmation

- Always show diff summary before committing
- Require confirmation for commits >500 lines changed
- For splits: guide user through `git add -p` if needed

## Constraints

- **Never commit secrets**: .env, secrets.*, *.key, credentials.*
- **No Claude authorship**: Never add "Generated with Claude" or co-author tags
- **Atomic commits**: Single logical purpose per commit
- **User confirmation**: Always confirm before executing commit

## Example Interaction

```text
✓ Staged: src/auth/login.py, tests/test_login.py
✓ Changes: Added OAuth2 flow + corresponding tests

Suggestion: Single logical change, creating commit:
→ feat: ✨ add OAuth2 authentication flow
```

## Reference Documentation

For detailed information on commit formats and conventions:

- **`references/conventional-commits.md`** — Conventional commits specification,
  structure, types, breaking changes, and footers
- **`references/commit-templates.md`** — Commit message templates with emoji
  indicators for all commit types
