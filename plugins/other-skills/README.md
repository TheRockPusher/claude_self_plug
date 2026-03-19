# other-skills

Collection of standalone skills for Claude Code.

## Skills

### excalidraw-diagram

Generate `.excalidraw` JSON files that argue visually, not just display
information. Includes a Playwright-based render pipeline for visual
validation.

**Trigger**: Ask Claude to create a diagram, visualise a workflow,
architecture, or concept.

**Prerequisites**:

- Python 3.11+
- [uv](https://docs.astral.sh/uv/) package manager

**First-time setup** (run once per project):

```bash
cd <plugin-root>/skills/excalidraw-diagram/references
uv sync
uv run playwright install chromium
```

**Credit**: Based on
[coleam00/excalidraw-diagram-skill](https://github.com/coleam00/excalidraw-diagram-skill).

## Installation

```bash
claude --plugin-dir ./plugins/other-skills
```
