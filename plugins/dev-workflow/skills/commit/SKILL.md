---
name: commit
description: >-
  This skill should be used when the user asks to "commit changes",
  "create a commit", "make a commit", "git commit", "commit this",
  "commit my changes", or wants well-formatted git commits.
---

# Commit

Create atomic, well-formatted git commits following conventional commit
standards with emoji indicators.

**Core Principle**: Analyse changes thoroughly, suggest logical groupings,
and create clean commit history.

## Process

### Phase 1: Review Current State

Run these commands to gather context:

```bash
git status
git diff --staged
git diff
git log -5 --oneline
```

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

## Commit Type Reference

- **feat**: ✨ New feature
- **fix**: 🩹 Bug fix (minor)
- **fix**: 🚑️ Critical hotfix
- **refactor**: 🔨 Code restructure
- **perf**: ⚡ Performance improvement
- **test**: 🚦 Test additions/changes
- **docs**: 📜 Documentation
- **style**: 💅 Formatting/style
- **build**: 📦 Build system/deps
- **ci**: 🦊 CI configuration
- **chore**: 🧹 Maintenance tasks
- **debug**: 🧪 Debugging changes
- **BREAKING**: 💣 Breaking changes

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

## Example Commit Messages

**Simple:**

```text
feat: ✨ add user authentication system
```

**With scope:**

```text
feat(auth): ✨ add user authentication system
```

**With body:**

```text
feat(auth): ✨ add user authentication system

Implements JWT-based authentication with:
- Login endpoint with credentials validation
- Token generation and verification
- Protected route middleware
```

## Reference

[Conventional Commits](https://www.conventionalcommits.org/)
