# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Repository Purpose

This is a personal Claude Code plugin marketplace repository that hosts
custom plugins for enhancing Claude Code's capabilities. The primary focus
is development workflow automation through the `dev-workflow` plugin.

## Repository Structure

```text
.
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest defining available plugins
├── plugins/
│   └── dev-workflow/             # Development workflow plugin
│       ├── .claude-plugin/
│       │   └── plugin.json       # Plugin metadata (name, version, description)
│       ├── skills/               # User-invocable skills (slash commands)
│       │   ├── primer/           # Codebase analysis and context generation
│       │   ├── plan/             # Implementation planning
│       │   ├── implement/        # Plan execution with validation
│       │   └── commit/           # Git commit formatting
│       ├── hooks/                # Event-triggered automation
│       │   ├── hooks.json        # Hook definitions
│       │   └── lint-markdown.sh  # PostToolUse hook for markdown linting
│       └── README.md
├── reference/                    # Legacy reference files
└── README.md
```

## Plugin Architecture

### Plugin Manifest (`.claude-plugin/marketplace.json`)

The marketplace manifest defines all available plugins:

```json
{
  "name": "claude-self-plug",
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./plugins/plugin-name",
      "description": "...",
      "category": "development",
      "keywords": [...]
    }
  ]
}
```

Each plugin entry must match a corresponding directory under `plugins/`.

### Plugin Structure

Each plugin requires:

1. **Plugin manifest**: `.claude-plugin/plugin.json` with name, version, description
2. **Skills** (optional): `skills/skill-name/SKILL.md` with YAML frontmatter
3. **Hooks** (optional): `hooks/hooks.json` defining event-triggered commands
4. **README.md**: Plugin documentation with prerequisites, installation, usage

### Skill Structure

Skills are user-invocable commands defined in `skills/{skill-name}/SKILL.md`:

```markdown
---
name: skill-name
description: Trigger phrases and when this skill should be used
---

# Skill Title

[Skill implementation instructions...]
```

**Critical**: Skill names MUST be lowercase to appear in Claude Code's
skill menu. The `description` field in frontmatter defines when the skill
should be triggered.

Skills may reference supporting files in `references/` subdirectory for
templates or additional documentation.

### Hook Structure

Hooks are defined in `hooks/hooks.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/script.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

Hook scripts receive tool use data via stdin as JSON and can output
structured feedback to Claude.

## dev-workflow Plugin

The dev-workflow plugin implements a three-phase development workflow:

### Phase 1: Primer (`/primer`)

- Analyzes codebase using `git ls-files` and parallel Task agents
- Generates persistent context docs in `.agents/context/`:
  - `ARCHITECTURE.md` — Structure, patterns, components
  - `CONVENTIONS.md` — Code style, naming, testing
  - `CODE-MAP.md` — File organization
- Uses AskUserQuestion for approval before writing

### Phase 2: Plan (`/plan`)

- Creates implementation plans in `.agents/plans/{feature-name}.md`
- Launches parallel agents for codebase intelligence gathering
- Researches external documentation (llms.txt, Context7 MCP, official docs)
- Includes mandatory 5-level validation checklist
- Assigns confidence score (1-10)

### Phase 3: Implement (`/implement`)

- Executes plans with mandatory validation iteration loop
- Loads context from `.agents/context/` before coding
- Uses TodoWrite to track progress
- Runs validation commands until all checks pass
- Produces completion report

### Commit (`/commit`)

- Formats git commits following project conventions

## Adding New Plugins

1. Create plugin directory: `plugins/{plugin-name}/`
2. Add plugin manifest: `plugins/{plugin-name}/.claude-plugin/plugin.json`
3. Create skills, hooks, or agents as needed
4. Add plugin entry to `.claude-plugin/marketplace.json`
5. Update README.md plugin catalog table
6. Write plugin README.md with prerequisites and usage

## Testing Plugins

Test without installation using:

```bash
claude --plugin-dir /path/to/plugins/{plugin-name}
```

Or test from this repository root:

```bash
claude --plugin-dir ./plugins/dev-workflow
```

## Validation and Quality

The dev-workflow plugin enforces markdown linting via PostToolUse hook:

- Automatically runs `markdownlint-cli2 --fix` after Write/Edit operations
  on `.md` files
- Reports remaining lint errors back to Claude for manual fixing
- Requires Node.js and `markdownlint-cli2` (installed via npx)

## Key Conventions

- Skill names: lowercase for menu visibility
- Output locations: `.agents/context/` for primer, `.agents/plans/` for plans
- File references: Use `file:line` format in documentation
- Hook scripts: Use `${CLAUDE_PLUGIN_ROOT}` for plugin-relative paths
- Validation: Always include executable commands in plans
- Never glob: `.venv/`, `node_modules/`, `dist/`, `build/`, `.git/`
- Version bumping: Always bump plugin version in `plugin.json` before pushing.
  If uncertain about the bump type (major/minor/patch), ask the user

## Prerequisites

For dev-workflow plugin:

- Node.js (v18+) for markdown linting
- jq for JSON processing in hooks
- Git repository (for `git ls-files` discovery)
