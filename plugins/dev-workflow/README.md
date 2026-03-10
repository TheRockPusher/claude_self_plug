# dev-workflow

Development workflow plugin for [Claude Code](https://docs.anthropic.com/en/docs/claude-code):
brainstorming, context priming, implementation planning, execution with
validation, git commits, PR/MR creation, and README generation.

**Version**: 0.4.0
**License**: [MIT](../../LICENSE)
**Author**: TheRockPusher

## Prerequisites

### System Requirements

- **Node.js** (v18+) — required for markdown linting hook
- **jq** — JSON processor for hook scripts
- **Git** — repository context discovery

### Installing Prerequisites

**Ubuntu/Debian:**

```bash
sudo apt install nodejs npm jq
```

**Arch Linux:**

```bash
sudo pacman -S nodejs npm jq
```

**macOS:**

```bash
brew install node jq
```

### NPM Dependencies

```bash
npm install markdownlint-cli2
```

Or let the hook install it automatically via `npx` on first use.

## Installation

```bash
# Add to Claude Code settings
claude settings plugins add /path/to/plugins/dev-workflow

# Or use --plugin-dir for testing
claude --plugin-dir /path/to/plugins/dev-workflow
```

## Skills

| Skill          | Trigger Phrases                                                  | Purpose                                               |
| -------------- | ---------------------------------------------------------------- | ----------------------------------------------------- |
| `brainstorm`   | "brainstorm", "discuss an idea", "explore options"               | Interactive dialogue to reach a YAGNI solution        |
| `load-context` | "load context", "load dev context", "inject context"             | Load dev principles and language conventions           |
| `primer`       | "map the codebase", "prime context", "create architecture docs"  | Generate persistent context docs                      |
| `plan-dev`     | "create a plan", "plan implementation", "design a feature"       | Create implementation plans with validation steps     |
| `implement`    | "implement the plan", "execute the plan", "build this"           | Execute plans with mandatory validation iteration     |
| `commit`       | "commit changes", "create a commit", "git commit"                | Atomic conventional commits with emoji indicators     |
| `create-pr`    | "create a PR", "open a pull request", "create a merge request"   | PR/MR creation for GitHub and GitLab                  |
| `readme`       | "create a README", "generate a README", "document this project"  | Standards-compliant README generation                 |

## Hooks

### PreToolUse (Security)

| Matcher                    | Script                  | Purpose                                                  |
| -------------------------- | ----------------------- | -------------------------------------------------------- |
| `Write\|Edit`              | `block-config-edits.sh` | Block edits to CI/CD, lock files, infrastructure configs |
| `Read\|Glob\|Grep\|Bash`  | `block-secret-reads.sh` | Block reads of .env, API keys, SSH keys, credentials     |

Both security hooks have easily customizable pattern arrays at the top of
each script. Edit the `BLOCKED_PATTERNS` / `BLOCKED_EXTENSIONS` arrays to
add or remove protections for your team.

### PostToolUse (Formatting)

| Matcher       | Script            | Purpose                              |
| ------------- | ----------------- | ------------------------------------ |
| `Write\|Edit` | `lint-markdown.sh` | Auto-fix and report markdown lint issues |
| `Write\|Edit` | `lint-python.sh`  | Auto-format Python files             |

## Workflow

The core skills form a development workflow:

```text
1. /brainstorm    → Talk through ideas, reach a simple solution
2. /load-context  → Inject language conventions into the session
3. /primer        → Analyse codebase, generate context docs
4. /plan-dev      → Design implementation strategy with validation
5. /implement     → Execute plan with mandatory validation iteration
6. /commit        → Create well-formatted atomic commits
7. /create-pr     → Push and open a PR/MR with description
8. /readme        → Generate or update project README
```

### Primer

Generates persistent context documents in `.agents/context/`:

- `ARCHITECTURE.md` — Structure, patterns, components
- `CONVENTIONS.md` — Code style, naming, testing
- `CODE-MAP.md` — File purposes and organisation

### Plan

Creates implementation plans in `.agents/plans/`:

- Gathers codebase intelligence with parallel analysis agents
- Researches external documentation
- Produces step-by-step tasks with validation commands
- Includes confidence scoring

### Implement

Executes plans or inline instructions:

- Loads mandatory context before coding
- Tracks progress with TodoWrite
- **Mandatory validation iteration** — loops until all checks pass
- Produces completion report

## Output Locations

| Skill       | Output                              |
| ----------- | ----------------------------------- |
| `primer`    | `.agents/context/*.md`              |
| `plan-dev`  | `.agents/plans/*.md`                |
| `brainstorm`| `.agents/brainstorms/*.md`          |
| `implement` | Code changes + validation report    |

## Requirements

- Claude Code with plugin support
- Git repository (for `git ls-files` discovery)
- Project validation commands (lint, test, etc.)
