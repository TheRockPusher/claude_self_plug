# dev-workflow

Development workflow skills for Claude Code: context priming, implementation
planning, and execution with validation.

## Prerequisites

### System Requirements

- **Node.js** (v18+) - Required for markdown linting hook
- **jq** - JSON processor for hook scripts

### Installation

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

## Skills

### primer

- **Trigger Phrases**: "map the codebase", "prime context", "create architecture
  docs"
- **Purpose**: Generate persistent context documents

### plan

- **Trigger Phrases**: "create a plan", "plan implementation", "design a
  feature"
- **Purpose**: Create comprehensive implementation plans

### implement

- **Trigger Phrases**: "implement the plan", "execute the plan", "build this"
- **Purpose**: Execute plans with validation

## Installation

```bash
# Add to Claude Code settings
claude settings plugins add /path/to/plugins/dev-workflow

# Or use --plugin-dir for testing
cc --plugin-dir /path/to/plugins/dev-workflow
```

## Workflow

The three skills form a development workflow:

```text
1. /primer     → Understand the codebase, generate context docs
2. /plan       → Design implementation strategy with validation
3. /implement  → Execute plan with mandatory validation iteration
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

- **primer**: `.agents/context/*.md`
- **plan**: `.agents/plans/*.md`
- **implement**: Code changes + validation report

## Requirements

- Claude Code with plugin support
- Git repository (for `git ls-files` discovery)
- Project validation commands (lint, test, etc.)
