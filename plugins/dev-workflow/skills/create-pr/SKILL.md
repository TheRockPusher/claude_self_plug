---
name: create-pr
description: ALWAYS USE THIS SKILL when the user asks to "create a PR", "open a pull request", "create a merge request", "push and create PR", "submit PR", "create MR", "/create-pr", or mentions wanting to open a PR/MR for their changes. Orchestrates the full PR/MR creation workflow with intelligent branch management, conventional commit titles, and OSS-quality descriptions. Supports both GitHub (gh) and GitLab (glab).
argument-hint: "[optional: base-branch]"
allowed-tools: Bash(git*), Bash(gh*), Bash(glab*), Bash(jq*), AskUserQuestion, Read
model: haiku
context: fork
---

# Create Pull Request / Merge Request

Orchestrate the full PR/MR creation workflow: analyse changes, craft an
OSS-quality description, handle branch management, and open the PR/MR
via the appropriate CLI (`gh` for GitHub, `glab` for GitLab).

**Core Principle**: Produce PRs/MRs that reviewers can understand in
under 60 seconds. Focus on the **why**, not the what.

## Process

### Phase 1: Gather Context

Collect repository and change state:

- Status: !`git status`
- Current branch: !`git branch --show-current`
- Default branch:
  !`git remote show origin 2>/dev/null`
  Parse the "HEAD branch:" line from the output to determine the
  default branch name
- Staged diff: !`git diff --staged --stat`
- Full diff: !`git diff HEAD --stat`
- Recent commits on branch: !`git log --oneline -20`
- Remote tracking:
  !`git rev-parse --abbrev-ref @{upstream} 2>/dev/null || echo "no upstream"`
- Remote URL:
  !`git remote get-url origin 2>/dev/null`

### Phase 1.5: Detect Platform

Determine whether the remote is GitHub or GitLab by inspecting the
origin URL:

- **GitHub**: URL contains `github.com` -> use `gh` CLI
- **GitLab**: URL contains `gitlab.com` or `gitlab.` -> use `glab` CLI
- **Ambiguous**: Ask the user which platform to use

Store the detected platform for all subsequent phases. Use the
variable `CLI` to refer to either `gh` or `glab` throughout.

### Phase 2: Validate Prerequisites

**Fail fast if:**

- No changes exist (no staged, unstaged, or unpushed commits)
- The required CLI tool is not installed or not authenticated
- Repository has no remote

**Check authentication:**

For GitHub:

```bash
gh auth status
```

For GitLab:

```bash
glab auth status
```

### Phase 3: Branch Management

Determine current branch state and act accordingly:

- **On default branch with uncommitted changes** -> Create a new feature
  branch. Derive branch name from changes (e.g., `feat/add-oauth-flow`).
  Ask the user to confirm the branch name before creating
- **On default branch with existing commits** -> Suggest creating a branch
  from current HEAD. Ask the user before proceeding
- **On feature branch** -> Continue with current branch
- **No upstream set** -> Push with `-u` flag when pushing

### Phase 4: Stage and Commit (if needed)

If uncommitted changes exist:

- Show the user a summary of uncommitted changes
- Ask whether to commit them before creating the PR
- If yes, create a commit following the project's conventional commit style
  (match existing commit message patterns from `git log`)
- If no, proceed with only already-committed changes

### Phase 5: Push to Remote

Push the branch to origin:

```bash
git push -u origin <branch-name>
```

If the push fails due to diverged history, inform the user and ask how
to proceed. **Never force-push without explicit user approval.**

### Phase 6: Analyse Changes for PR Description

Gather the full scope of changes against the base branch:

```bash
git log <base-branch>..HEAD --oneline
git diff <base-branch>...HEAD --stat
git diff <base-branch>...HEAD
```

Analyse ALL commits in the branch, not just the latest one.

Determine:

- **PR type**: feat, fix, refactor, docs, perf, test, build, ci, chore
- **Scope**: Which subsystem or component is affected
- **Breaking changes**: Any API or behaviour changes that affect consumers
- **Related issues**: Extract issue references from commit messages or
  branch name

### Phase 7: Craft PR Title

Format the title following conventional commits:

```text
<type>(<scope>): <emoji> <short description>
```

**Rules:**

- Keep under 70 characters total
- Use imperative mood ("add" not "added")
- Match the emoji convention from `references/pr-templates.md`
- Include scope when changes are localised to a subsystem

**Examples:**

- `feat(auth): add OAuth2 login flow`
- `fix(api): resolve race condition in cache refresh`
- `refactor: extract validation utilities`

### Phase 8: Craft PR Description

Select the appropriate template tier based on change complexity:

- **Minimal** (single-purpose, <100 lines changed) -> Summary + Test Plan
- **Standard** (most PRs) -> Summary + Changes + Test Plan + Related Issues
- **Comprehensive** (breaking changes, large features, multi-subsystem)
  -> Full template with Breaking Changes, Type, Checklist

Consult `references/pr-templates.md` for the exact template formats.

**Description guidelines:**

- Summary explains **motivation and why**, not what (the diff shows what)
- Changes section uses concise bullet points
- Test Plan includes exact commands or evidence of testing
- Reference issues with `Fixes #N` or `Closes #N` syntax

### Phase 9: User Confirmation

Present the complete PR to the user before creation:

```text
PR Title: feat(auth): add OAuth2 login flow
Base: main <- Branch: feat/add-oauth-flow
Template: Standard

--- PR Description Preview ---
[full description]
```

Ask the user to confirm or request changes. Iterate until approved.

### Phase 10: Create the PR/MR

Create the PR/MR using the detected platform CLI.

**For GitHub:**

```bash
gh pr create --title "<title>" --base "<base-branch>" \
  --body "$(cat <<'EOF'
<body>
EOF
)"
```

**For GitLab:**

Consult `references/glab-reference.md` for the full flag reference
and known gotchas. Key points:

- glab uses `--description` (not `--body`) and `--target-branch`
  (not `--base`)
- Non-interactive mode requires BOTH `--title` AND `--description`
- Always pass `--yes` to skip the confirmation prompt
- Always double-quote shell variables to prevent word-splitting errors
- Use HEREDOC via command substitution for multi-line descriptions

```bash
glab mr create --title "<title>" \
  --target-branch "<base-branch>" \
  --description "$(cat <<'EOF'
<body>
EOF
)" --yes
```

**Do NOT use `--fill`** unless the user explicitly asks for it,
because `--fill` implicitly pushes the branch and overrides the
crafted title and description.

**After creation:**

- Display the PR/MR URL
- Show a brief summary of what was created

If the `--base` argument was provided via `$ARGUMENTS`, use that as
the base/target branch. Otherwise, default to the repository's
default branch.

## Constraints

- **No AI attribution**: NEVER add "Generated with Claude Code",
  "Co-Authored-By: Claude", "Created by Claude", "AI-generated",
  or ANY similar attribution text to the PR/MR title, description,
  or commit messages. The PR/MR must read as if written by the user
- **Never force-push** without explicit user approval
- **Never push to default branch** directly
- **Always confirm** the PR title and description before creation
- **Preserve existing commits**: Do not amend, squash, or rebase without
  user request

## Reference Documentation

For detailed templates, best practices, and CLI references:

- **`references/pr-templates.md`** -- Three-tier PR description templates
  inspired by React, Kubernetes, Angular, and other major OSS projects.
  Includes emoji reference, title conventions, and template selection guide
- **`references/pr-best-practices.md`** -- Synthesised best practices from
  14 major open source projects covering description quality, test evidence,
  review readiness, and common anti-patterns
- **`references/glab-reference.md`** -- Complete glab CLI reference for
  merge request creation. Includes all `glab mr create` flags, non-interactive
  usage patterns, multi-line description techniques, known gotchas, and
  a flag mapping between `glab` and `gh`. **Consult this before running
  any glab command.**
