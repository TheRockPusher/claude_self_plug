# glab CLI Reference for Merge Request Creation

Comprehensive reference for using the GitLab CLI (`glab`) to create and
manage merge requests programmatically.

---

## Authentication

### Check Status

```bash
glab auth status
glab auth status --all          # all configured instances
glab auth status --show-token   # display token
```

### Login Methods

```bash
# Interactive (recommended)
glab auth login

# Self-managed instance
glab auth login --hostname gitlab.example.org

# Token-based (non-interactive)
glab auth login --hostname gitlab.example.org --token glpat-xxx

# CI/CD pipeline
glab auth login --hostname "$CI_SERVER_HOST" --job-token "$CI_JOB_TOKEN"

# Token from stdin
echo "$MY_TOKEN" | glab auth login --stdin --hostname gitlab.example.com
```

### Environment Variables

These override stored credentials (in priority order):

| Variable               | Purpose                   |
| ---------------------- | ------------------------- |
| `GITLAB_TOKEN`         | Primary API token         |
| `GITLAB_ACCESS_TOKEN`  | Alternative token         |
| `OAUTH_TOKEN`          | OAuth token               |
| `GITLAB_HOST`          | Default GitLab instance   |

---

## `glab mr create` -- Complete Reference

**Alias:** `glab mr new`

### All Flags

#### Content Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--title`              | `-t`  | MR title (required for non-interactive mode)  |
| `--description`        | `-d`  | MR description. Set to `"-"` to open editor   |
| `--signoff`            |       | Append DCO signoff to description             |

#### Branch Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--source-branch`      | `-s`  | Source branch (default: current branch)        |
| `--target-branch`      | `-b`  | Target/base branch to merge into              |
| `--create-source-branch` |     | Create source branch if it does not exist      |

#### Assignment Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--assignee`           | `-a`  | Assign by username (comma-separated or repeat) |
| `--reviewer`           |       | Request review by username                    |
| `--label`              | `-l`  | Add labels (comma-separated or repeat)         |
| `--milestone`          | `-m`  | Milestone global ID or title                  |

#### Automation Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--fill`               | `-f`  | Use commit info for title/description. **WARNING: implicitly enables `--push`** |
| `--fill-commit-body`   |       | Fill description with commit bodies. Requires `--fill` |
| `--push`               |       | Push committed changes after creating MR      |
| `--yes`                | `-y`  | Skip submission confirmation prompt           |
| `--no-editor`          |       | Don't open editor; use text prompt instead    |
| `--web`                | `-w`  | Continue creation in web browser              |

#### Merge Behaviour Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--draft`              |       | Mark MR as draft                              |
| `--wip`                |       | Mark as draft (legacy alternative)            |
| `--remove-source-branch` |    | Delete source branch after merge              |
| `--squash-before-merge`  |    | Squash commits when merging                   |
| `--allow-collaboration`  |    | Allow commits from other members              |

#### Other Flags

| Flag                   | Short | Description                                   |
| ---------------------- | ----- | --------------------------------------------- |
| `--related-issue`      | `-i`  | Link MR to an issue. Uses issue title if `--title` omitted |
| `--copy-issue-labels`  |       | Copy labels from linked issue. Requires `--related-issue` |
| `--head`               | `-H`  | Source repository (OWNER/REPO or URL)         |
| `--repo`               | `-R`  | Target repository (OWNER/REPO or URL)         |
| `--recover`            |       | **(EXPERIMENTAL)** Save/load options on failure |

---

## Non-Interactive Usage (Critical)

For fully non-interactive MR creation, you **must** provide BOTH
`--title` AND `--description`, or use `--fill`:

```bash
# Option A: explicit title + description (recommended for scripted use)
glab mr create --title "Title" --description "Description" --yes

# Option B: fill from commits (WARNING: also pushes the branch)
glab mr create --fill --yes

# Option C: title with empty description
glab mr create --title "Title" --description "" --yes
```

**Providing only `--title` without `--description` will trigger
interactive mode or error.**

---

## Multi-Line Descriptions

### HEREDOC via Command Substitution (recommended for scripts)

```bash
glab mr create --title "Title" --description "$(cat <<'EOF'
## Summary
- Change 1
- Change 2

## Test Plan
- Run unit tests
EOF
)" --yes
```

### Shell Quoting with Literal Newlines

```bash
glab mr create --title "Title" --description "Line 1
Line 2
Line 3" --yes
```

### Editor Mode

```bash
glab mr create --title "Title" --description "-"
```

Setting description to `"-"` opens the `$EDITOR`.

**Important:** Always quote variables when passing descriptions to
prevent word-splitting issues:

```bash
# CORRECT
glab mr create --title "$title" --description "$desc" --yes

# WRONG -- breaks if variables contain spaces
glab mr create --title $title --description $desc --yes
```

---

## Known Gotchas

### `--fill` Implicitly Pushes

The `--fill` flag automatically sets `--push` to `true`. Even
`--push=false` alongside `--fill` may not override this. If you want
commit info without pushing, extract it manually with `git log` and
pass via `--title` and `--description`.

### Variable Quoting

Unquoted shell variables cause "accepts 0 arg(s), received N" errors.
Always double-quote variables in glab commands.

### Templates Relative to CWD

MR templates are loaded from the current working directory's `.gitlab`
folder, not the repository root. Always run glab commands from the
repository root.

### Self-Managed Instance Auth

glab may default to `gitlab.com` even for self-managed repos. Always
verify with `glab auth status` and use `--hostname` when logging in
to self-managed instances.

---

## Other Useful MR Commands

| Command              | Description                          |
| -------------------- | ------------------------------------ |
| `glab mr list`       | List merge requests (alias: `ls`)    |
| `glab mr view`       | View MR details (`-w` for browser)   |
| `glab mr merge`      | Merge/accept MR (alias: `accept`)    |
| `glab mr approve`    | Approve a merge request              |
| `glab mr update`     | Modify MR properties                 |
| `glab mr checkout`   | Check out MR branch locally          |
| `glab mr note`       | Add comment to MR                    |
| `glab mr diff`       | View MR diff                         |
| `glab mr close`      | Close a merge request                |
| `glab mr rebase`     | Rebase a merge request               |

---

## `glab mr create` vs `gh pr create` Mapping

| Aspect            | glab (GitLab)            | gh (GitHub)              |
| ----------------- | ------------------------ | ------------------------ |
| Create MR/PR      | `glab mr create`         | `gh pr create`           |
| Title flag        | `--title` / `-t`         | `--title` / `-t`         |
| Description flag  | `--description` / `-d`   | `--body` / `-b`          |
| Target branch     | `--target-branch` / `-b` | `--base` / `-B`          |
| Source branch     | `--source-branch` / `-s` | `--head` / `-H`          |
| Draft             | `--draft`                | `--draft`                |
| Assignee          | `--assignee` / `-a`      | `--assignee` / `-a`      |
| Reviewer          | `--reviewer`             | `--reviewer`             |
| Label             | `--label` / `-l`         | `--label` / `-l`         |
| Milestone         | `--milestone` / `-m`     | `--milestone` / `-m`     |
| Auto-fill         | `--fill` / `-f`          | `--fill`                 |
| Skip confirmation | `--yes` / `-y`           | (no equivalent)          |
| Open in browser   | `--web` / `-w`           | `--web` / `-w`           |

**Key difference:** glab uses `--description` / `-d` while gh uses
`--body` / `-b`. glab uses `--target-branch` / `-b` while gh uses
`--base` / `-B`.

---

## Issue Reference Syntax (GitLab)

| Keyword            | Effect                         |
| ------------------ | ------------------------------ |
| `Fixes #N`         | Closes issue when MR merges    |
| `Closes #N`        | Closes issue when MR merges    |
| `Resolves #N`      | Closes issue when MR merges    |
| `Related to #N`    | Links without closing          |
| `group/project#N`  | Cross-project reference        |
| `/close #N`        | Quick action in MR description |
