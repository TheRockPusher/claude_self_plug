---
name: plan
description: ALWAYS USE THIS SKILL when the user asks to "create a plan", "plan implementation", "design a feature", "/plan", or mentions needing a comprehensive plan before coding. Creates detailed implementation plans in .agents/plans/ through multi-phase analysis: codebase intelligence gathering (parallel Task agents), external research (llms.txt, Context7 MCP, web search), and strategic planning with mandatory 5-level validation commands.
argument-hint: [feature-description]
allowed-tools: Read, Grep, Glob, Bash(git status*), Bash(git log*), Bash(git ls-files*), Bash(git diff*), Task, WebFetch, WebSearch, Write, AskUserQuestion
context: fork
model: opus
---

# Plan

Transform a feature request into a comprehensive implementation plan through
systematic codebase analysis, external research, and strategic planning.

**Core Principle**: NO CODE in this phase. Create a context-rich plan that
enables one-pass implementation success.

**Key Philosophy**: Context is King. The plan must contain ALL information
needed—patterns, mandatory reading, documentation, validation commands—so
execution succeeds on first attempt.

## Output

Write plan to `.agents/plans/{kebab-case-feature-name}.md`

Use the template in `references/plan-template.md`.

## Process

### Phase 0: Project Rules Check

**Mandatory first step:**

1. Read `CLAUDE.md` or `AGENTS.md` if present
2. Extract project-specific conventions and forbidden patterns
3. Note required tools, testing frameworks, and validation commands
4. Identify any AI-specific instructions that override defaults

### Phase 0.5: Load Primer Context

**If `.agents/context/` exists, load these files before analysis:**

| File | What to Extract |
| --- | --- |
| `ARCHITECTURE.md` | Structure, components, dependencies, entry points |
| `CONVENTIONS.md` | Naming, imports, error handling, logging patterns |
| `CODE-MAP.md` | File organisation, module purposes |

This context from the primer skill accelerates Phase 2 analysis and ensures
consistency with documented project patterns. Skip redundant discovery if
primer docs are comprehensive and recent.

### Phase 1: Feature Understanding

Analyse the request:

- **Core problem** being solved
- **User value** and business impact
- **Feature type**: New Capability / Enhancement / Refactor / Bug Fix
- **Complexity**: Low / Medium / High
- **Affected systems** and components

**If requirements are unclear**: Use AskUserQuestion before proceeding.

### Phase 2: Codebase Intelligence Gathering

Launch parallel **Explore agents** (Task tool with `subagent_type=Explore`):

| Agent | Focus |
| --- | --- |
| Structure | Languages, frameworks, directory patterns, config files |
| Patterns | Similar implementations, naming, error handling, logging |
| Testing | Framework, structure, coverage, similar test examples |
| Integration | Files needing updates, new files, registration patterns |

**For each Explore agent, extract:**

- Specific file paths with line numbers
- Real code examples (not placeholders)
- Anti-patterns to avoid

**Note:** If primer context (Phase 0.5) already covers an area comprehensively,
skip that agent and reference the primer docs instead.

### Phase 3: External Research

Launch parallel **general-purpose agents** (one per documentation source):

| Agent | Task |
| --- | --- |
| LLMs.txt | Fetch `https://{domain}/llms.txt` or `/llms-full.txt` |
| Context7 | Use MCP if available (`resolve-library-id` + `get-library-docs`) |
| Official Docs | Fetch official documentation with section anchors |
| Web Search | Search for specific implementation patterns (last resort) |

**Documentation lookup priority:**

1. llms.txt files (AI-optimised documentation)
2. Context7 MCP (if available)
3. Official documentation
4. Web search

**For each agent, gather:**

- Latest library versions and best practices
- Implementation examples
- Common gotchas and known issues
- Breaking changes and migration guides

**Note:** Only launch agents for libraries/frameworks relevant to the feature.
Skip agents for well-understood or already-documented dependencies.

### Phase 4: Strategic Thinking

Consider:

- How does this fit into existing architecture?
- Critical dependencies and order of operations?
- What could go wrong? (edge cases, race conditions, errors)
- How will this be tested comprehensively?
- Performance implications?
- Security considerations?

### Phase 5: Plan Generation

Write plan following the template in `references/plan-template.md`.

### Phase 6: Plan Quality Validation

Self-review checklist:

**Context Completeness:**

- [ ] All necessary patterns identified with file:line references
- [ ] External library usage documented with links
- [ ] Integration points clearly mapped
- [ ] Every task has executable validation command

**Implementation Ready:**

- [ ] Another developer could execute without additional context
- [ ] Tasks ordered by dependency (top-to-bottom execution)
- [ ] Each task is atomic and independently testable
- [ ] Pattern references include specific file:line numbers

**Validation Completeness (CRITICAL):**

The plan MUST include executable validation commands for all 5 levels:

- [ ] **Level 1 (Lint/Format)**: e.g., `ruff check .`, `npm run lint`
- [ ] **Level 2 (Type Safety)**: e.g., `mypy .`, `npx tsc --noEmit`
- [ ] **Level 3 (Unit Tests)**: e.g., `pytest`, `npm test`
- [ ] **Level 4 (Integration Tests)**: Command or note if not applicable
- [ ] **Level 5 (Manual)**: Specific manual validation steps

**How to find validation commands:**

1. Read CLAUDE.md for project-specific commands
2. Check for Makefile targets (`make check`, `make test`)
3. Check package.json scripts (`npm run lint`, `npm run test`)
4. Check pyproject.toml for tool configurations
5. Look for CI/CD files (.github/workflows/)

## Confidence Score

- **9-10**: All patterns identified, clear path → Proceed
- **7-8**: Minor unknowns, solid foundation → Proceed with notes
- **5-6**: Some gaps, may need clarification → Review with user
- **3-4**: Significant unknowns → Ask for input
- **1-2**: Major blockers → Cannot proceed

**Score below 7?** Ask user for clarification before finalising.

## Plan Size Guidelines

- **Target**: 200-400 lines for typical features
- **Maximum**: 800 lines (larger plans should split)

If plan exceeds 500 lines, split into parts:

- `.agents/plans/{feature}-part1-foundation.md`
- `.agents/plans/{feature}-part2-implementation.md`

## Output Report

After creating the plan, report:

1. **Summary**: Feature and approach (2-3 sentences)
2. **File path**: Full path to created plan
3. **Complexity**: Low / Medium / High with rationale
4. **Key risks**: Implementation risks or considerations
5. **Confidence score**: X/10 with brief justification
