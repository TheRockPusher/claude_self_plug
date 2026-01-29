# Brainstorm: Dynamic Context Loading

> Generated: 2026-01-29
> Status: Ready for /plan

## Problem Statement

When working across multiple projects, the same principles and conventions
must be repeatedly explained to Claude:

- **Universal principles** (YAGNI, KISS, pure functions) need restating per
  project
- **Language-specific tooling** (Python → UV, Ruff, type safety) requires
  manual CLAUDE.md setup
- **Per-project friction** — setting up context for each new project is
  tedious

This wastes time and leads to inconsistent guidance when principles aren't
explicitly stated.

## Constraints & Parameters

### Hard Constraints (Non-negotiable)

- **Plugin-based**: Must live in dev-workflow plugin (portable,
  version-controlled)
- **File-based detection**: Detect language via config files (pyproject.toml,
  package.json)
- **Skill invocation**: Triggered via `/context` skill (reliable, explicit)
- **Concise content**: Context files should be ~50-100 lines (token-efficient)

### Soft Constraints (Preferences)

- Silent operation: No chat output when loading context
- Extensible: Easy to add new languages later
- Single CLAUDE.md line: Minimal per-project setup

### Out of Scope

- SessionStart hooks (known reliability issues with local plugins)
- Automatic detection without any CLAUDE.md line
- Detailed code examples in context files (keep concise)

## Context

### Related Systems

- **Existing primer skill**: Generates project-specific context in
  `.agents/context/`
- **CLAUDE.md hierarchy**: Claude Code's built-in context loading mechanism
- **Skill references pattern**: `skills/{skill}/references/` for supporting
  content

### Assumptions

- User has dev-workflow plugin installed: Required for skill access
- Projects have standard config files: pyproject.toml for Python,
  package.json for JS

## Options Explored

### Option 1: SessionStart Hook (Auto-load)

**Approach**: Use SessionStart hook to automatically detect and inject
context at session start.

**Trade-offs**:

| Aspect        | Assessment                              |
| ------------- | --------------------------------------- |
| Complexity    | Simple                                  |
| User friction | None (automatic)                        |
| Reliability   | Poor (known issues with local plugins)  |
| Control       | Low (always runs)                       |

**Verdict**: Rejected

**Reason**: SessionStart hooks have known reliability issues with local
file-based plugins. Not dependable enough for core functionality.

### Option 2: Skill in CLAUDE.md (Explicit)

**Approach**: Create `/context` skill that user invokes via one-liner in
CLAUDE.md: `Always invoke /context at session start.`

**Trade-offs**:

| Aspect        | Assessment                              |
| ------------- | --------------------------------------- |
| Complexity    | Simple                                  |
| User friction | Minimal (one line per project)          |
| Reliability   | High (skill invocation is stable)       |
| Control       | High (user decides when to use)         |

**Verdict**: Chosen

**Reason**: Reliable, explicit, minimal friction. One CLAUDE.md line is
acceptable trade-off for dependability.

### Option 3: User-level ~/.claude/CLAUDE.md

**Approach**: Put universal principles in `~/.claude/CLAUDE.md` (loads
globally).

**Trade-offs**:

| Aspect             | Assessment                              |
| ------------------ | --------------------------------------- |
| Complexity         | Simple                                  |
| Portability        | Poor (machine-specific)                 |
| Language detection | None (can't auto-detect per project)    |

**Verdict**: Rejected

**Reason**: Doesn't support language-specific loading. Would require
separate mechanism for Python/JS contexts.

## Chosen Solution

### Summary

Create a `/context` skill in the dev-workflow plugin that loads universal
development principles plus language-specific context based on detected
config files. Users enable it with a single CLAUDE.md line.

### Key Decisions

1. **Skill-based loading**: Use `/context` skill for reliability over
   SessionStart hooks
2. **File-based detection**: Check for pyproject.toml (Python),
   package.json (JS), Cargo.toml (Rust)
3. **Silent operation**: Read context files without outputting to chat
4. **Multi-language support**: If multiple config files exist, load all
   relevant contexts
5. **Concise principles**: Keep files to ~50-100 lines for token efficiency

### How It Works

1. User adds to project CLAUDE.md:
   `Always invoke /context at session start.`
2. Claude invokes `/context` skill at session start
3. Skill always loads `references/universal.md` (YAGNI, KISS, pure functions)
4. Skill checks project root for config files:
   - `pyproject.toml` or `requirements.txt` → load
     `references/languages/python.md`
   - `package.json` → load `references/languages/javascript.md`
   - `Cargo.toml` → load `references/languages/rust.md`
5. Context is read into Claude's working memory (no chat output)

### Simplifications Made

- **Python only initially**: Start with Python context, add other
  languages later
- **No user interaction**: Silent detection and loading, no prompts
- **No caching**: Re-detect each session (simple, always current)
- **Single directory scan**: Only check project root, not subdirectories

## Rationale

### Why This Solution

- **Reliable**: Skill invocation works consistently, unlike SessionStart hooks
- **Minimal friction**: One CLAUDE.md line per project
- **Extensible**: Adding a new language = adding a new markdown file
- **Token efficient**: Concise principles don't bloat context
- **Portable**: Lives in plugin, works across machines with same setup

### Why Not Alternatives

- **SessionStart hooks**: Too unreliable for core functionality
- **User-level CLAUDE.md**: Can't handle language-specific detection
- **Per-project verbose config**: Defeats the purpose of reducing friction

## Risks & Mitigations

| Risk                   | Likelihood | Impact | Mitigation                  |
| ---------------------- | ---------- | ------ | --------------------------- |
| User forgets CLAUDE.md | Low        | Med    | Document in plugin README   |
| Detection misses edge  | Low        | Low    | Manual specify in CLAUDE.md |
| Context too verbose    | Low        | Med    | Keep files concise, review  |

## Open Questions

- Should `/context` output a brief confirmation ("Loaded: universal +
  python")? Currently no, but could add as option.
- Should detection recurse into subdirectories for monorepos? Currently no,
  may add later.

## Next Steps

### Ready for Implementation

To proceed with implementation:

```bash
/plan dynamic-context-loading
```

**Implementation hints**:

- Start with: SKILL.md and universal.md
- Key pattern to follow: existing skill structure in `skills/primer/`
- File structure:

  ```text
  skills/context/
  ├── SKILL.md
  └── references/
      ├── universal.md
      └── languages/
          └── python.md
  ```

- Estimated complexity: Low

## Discussion Log

- **Pain points identified**: Repeating principles, language conventions,
  setup friction
- **Location decision**: Plugin-based (portable) over ~/.claude/
  (machine-specific)
- **Detection decision**: File-based auto-detect over explicit declaration
- **Timing decision**: Skill invocation over SessionStart (reliability
  concerns)
- **Scope decision**: Python only initially, extensible for other languages
- **Output decision**: Silent read, no chat clutter
- **Multi-lang decision**: Load all detected, don't ask user to choose
