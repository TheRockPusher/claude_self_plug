---
name: plan
description: This skill should be used when the user asks to "create a plan", "plan implementation", "design a feature", "write implementation plan", "plan this feature", "create implementation strategy", or wants a comprehensive plan before coding.
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

### Phase 1: Feature Understanding

Analyse the request:

- **Core problem** being solved
- **User value** and business impact
- **Feature type**: New Capability / Enhancement / Refactor / Bug Fix
- **Complexity**: Low / Medium / High
- **Affected systems** and components

**If requirements are unclear**: Use AskUserQuestion before proceeding.

### Phase 2: Codebase Intelligence Gathering

Launch parallel analysis agents:

- **Structure**: Languages, frameworks, directory patterns, config files
- **Patterns**: Similar implementations, naming, error handling, logging
- **Testing**: Framework, structure, coverage, similar test examples
- **Integration**: Files needing updates, new files, registration patterns

**For each agent, extract:**

- Specific file paths with line numbers
- Real code examples (not placeholders)
- Anti-patterns to avoid

### Phase 3: External Research

**Documentation lookup priority:**

1. Check `https://{domain}/llms.txt` or `/llms-full.txt`
2. Use Context7 MCP if available (`resolve-library-id` + `get-library-docs`)
3. Official documentation with section anchors
4. Web search as last resort

**Gather:**

- Latest library versions and best practices
- Implementation examples
- Common gotchas and known issues
- Breaking changes and migration guides

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
