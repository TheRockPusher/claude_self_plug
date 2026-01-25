# Claude Code Plugin Marketplace

A collection of plugins for
[Claude Code](https://docs.anthropic.com/en/docs/claude-code) - Anthropic's
official CLI for Claude.

## Prerequisites

### System Requirements

- **Node.js** (v18 or higher) - Required for markdown linting hooks
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

Install the required Node.js packages:

```bash
npm install markdownlint-cli2
```

Or let the hooks install them automatically via `npx` on first use.

## Plugins

**dev-workflow** - [plugins/dev-workflow/](plugins/dev-workflow/)

Development workflow skills: context priming, planning, implementation

## Plugin Installation

```bash
# Add a plugin to Claude Code
claude settings plugins add /path/to/plugins/dev-workflow

# Or use --plugin-dir for testing
cc --plugin-dir /path/to/plugins/dev-workflow
```

## Repository Structure

```text
claude_self_plug/
├── plugins/
│   └── dev-workflow/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── skills/
│       │   ├── primer/
│       │   ├── plan/
│       │   └── implement/
│       ├── hooks/
│       │   ├── hooks.json
│       │   └── lint-markdown.sh
│       └── README.md
├── reference/
│   └── .claude/
│       ├── commands/
│       └── settings.local.json
└── README.md
```

## Skills Overview

### primer

Generate persistent context documents that prime future AI sessions. Output
stored in `.agents/context/`:

- **ARCHITECTURE.md** - Structure, patterns, components, tooling
- **CONVENTIONS.md** - Code style, naming, testing standards
- **CODE-MAP.md** - File purposes and organization

**Trigger phrases:** "map the codebase", "prime context", "create architecture docs"

### plan

Transform feature requests into comprehensive implementation plans. Output
stored in `.agents/plans/`:

- Codebase intelligence gathering via parallel analysis
- External documentation research
- Step-by-step tasks with validation commands
- Confidence scoring (1-10)

**Trigger phrases:** "create a plan", "plan implementation", "design a feature"

### implement

Execute implementation plans with task tracking and validation:

- Mandatory context loading before implementation
- Task tracking with TaskCreate/TaskUpdate
- 5-level validation iteration (lint, types, unit tests, integration tests,
  manual)
- Completion reporting with metrics

**Trigger phrases:** "implement the plan", "execute the plan", "build this"

## Hooks

The dev-workflow plugin includes a PostToolUse hook that automatically lints
markdown files after Write or Edit operations using `markdownlint-cli2`.

## License

MIT
