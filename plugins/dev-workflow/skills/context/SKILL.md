---
name: context
description: This skill should be used when the user asks to "load context", "load dev context", "inject context", "/context", or when CLAUDE.md instructs "Always invoke /context at session start". Loads universal development principles and language-specific conventions based on detected project config files.
allowed-tools: Read, Glob
---

# Context

Load universal development principles and language-specific conventions into
the current session based on project detection.

## Purpose

Eliminate repetitive context-setting across projects by:

- Loading universal principles (YAGNI, KISS, pure functions) automatically
- Detecting project language via config files and loading relevant conventions
- Operating silently without chat output

## Process

### 1. Load Universal Principles

Always read `references/universal.md` into working memory.

### 2. Detect Project Language

Check project root for config files:

| Config File | Language | Context File |
| --- | --- | --- |
| `pyproject.toml` | Python | `languages/python.md` |
| `requirements.txt` | Python | `languages/python.md` |
| `package.json` | JS/TS | `languages/javascript.md` |
| `Cargo.toml` | Rust | `languages/rust.md` |
| `go.mod` | Go | `languages/go.md` |

Context files are in `references/` subdirectory.

### 3. Load Language Context

For each detected language, read the corresponding context file.

If multiple languages detected (e.g., monorepo with Python backend and
JS frontend), load all relevant contexts.

### 4. Silent Operation

Do not output anything to chat. The context is now in working memory for
the session.

## Detection Logic

Use Glob to check for config files in the project root:

```text
Glob: pyproject.toml
Glob: requirements.txt
Glob: package.json
Glob: Cargo.toml
Glob: go.mod
```

Load context for each file found. Missing files are silently ignored.

## Adding New Languages

To add support for a new language:

1. Create `references/languages/{language}.md`
2. Add detection rule to the table above
3. Keep content concise (~50-100 lines)
