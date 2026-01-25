# Implementation Plan Template

## Usage

Reference this template when generating implementation plans.

---

## Template

```markdown
# Feature: {Feature Name}

> **IMPORTANT**: Validate documentation and codebase patterns before implementing.
> Pay attention to naming of existing utils, types, and models.
> Import from correct files.

## Overview

**Description**: {Detailed description, purpose, user value}
**Problem**: {Specific problem or opportunity addressed}
**Solution**: {Proposed approach and how it solves the problem}

## Metadata

| Field | Value |
|-------|-------|
| Type | New Capability / Enhancement / Refactor / Bug Fix |
| Complexity | Low / Medium / High |
| Systems Affected | {List components/services} |
| Dependencies | {External libraries or services} |

---

## CONTEXT REFERENCES

### Mandatory Reading (READ BEFORE IMPLEMENTING)

- `path/to/file.py:15-45` - Why: Contains pattern for X to mirror
- `path/to/model.py:100-120` - Why: Database model structure
- `path/to/test.py` - Why: Test pattern example

### New Files to Create

- `path/to/new_service.py` - Service for X functionality
- `path/to/new_model.py` - Data model for Y resource
- `tests/path/to/test_new_service.py` - Unit tests

### Documentation References

- [Library Docs](https://example.com/docs#section) - Why: X functionality
- [Framework Guide](https://example.com/guide#integration) - Why: Integration patterns

### Patterns to Follow

**Naming:**
```python
# Example from codebase
```

**Error Handling:**

```python
# Example from codebase
```

**Logging:**

```python
# Example from codebase
```

### Boundaries

**ALWAYS:**

- {Mandatory patterns from CLAUDE.md}
- {Required validation before commit}

**ASK FIRST:**

- {Changes requiring user confirmation}
- {Architectural decisions}

**NEVER:**

- {Forbidden patterns}
- {Files not to modify}
- {Security anti-patterns}

---

## IMPLEMENTATION PLAN

### Phase 1: Foundation

{Foundational work before main implementation}

**Tasks:**

- Set up base structures (schemas, types, interfaces)
- Configure dependencies
- Create foundational utilities

### Phase 2: Core Implementation

{Main implementation work}

**Tasks:**

- Implement core business logic
- Create service layer components
- Add API endpoints/interfaces
- Implement data models

### Phase 3: Integration

{How feature integrates with existing functionality}

**Tasks:**

- Connect to existing routers/handlers
- Register new components
- Update configuration
- Add middleware if needed

### Phase 4: Testing & Validation

{Testing approach}

**Tasks:**

- Unit tests for each component
- Integration tests for workflows
- Edge case tests
- Acceptance criteria validation

---

## STEP-BY-STEP TASKS

> Execute every task in order, top to bottom. Each task is atomic and testable.

### Task Keywords

- **CREATE**: New files or components
- **UPDATE**: Modify existing files
- **ADD**: Insert functionality into existing code
- **REMOVE**: Delete deprecated code
- **REFACTOR**: Restructure without changing behaviour
- **MIRROR**: Copy pattern from elsewhere

### {ACTION} {target_file}

- **IMPLEMENT**: {Specific implementation detail}
- **PATTERN**: {Reference to existing pattern - file:line}
- **IMPORTS**: {Required imports}
- **GOTCHA**: {Known issues or constraints}
- **VALIDATE**: `{executable command}`

{Continue with all tasks in dependency order...}

---

## TESTING STRATEGY

### Unit Tests

{Scope based on project standards}

### Integration Tests

{Scope based on project standards}

### Edge Cases

- {Specific edge case 1}
- {Specific edge case 2}

---

## VALIDATION COMMANDS

> Execute every command to ensure zero regressions.

### Level 1: Syntax & Style

```bash
{project-specific lint/format commands}
```

### Level 2: Type Check

```bash
{project-specific type check commands}
```

### Level 3: Unit Tests

```bash
{project-specific test commands}
```

### Level 4: Integration Tests

```bash
{project-specific integration test commands}
```

### Level 5: Manual Validation

{Feature-specific manual testing steps}

---

## ACCEPTANCE CRITERIA

- [ ] Feature implements all specified functionality
- [ ] All validation commands pass with zero errors
- [ ] Unit test coverage meets requirements
- [ ] Integration tests verify end-to-end workflows
- [ ] Code follows project conventions
- [ ] No regressions in existing functionality
- [ ] Documentation updated (README, CLAUDE.md) if user-facing changes

---

## EXECUTION TODOS

> Pre-built todo structure for implementation agent:

1. Read all mandatory context files
2. Phase 1: Foundation tasks
3. Phase 2: Core implementation tasks
4. Phase 3: Integration tasks
5. Phase 4: Testing tasks
6. Run all validation commands
7. Verify acceptance criteria

---

## NOTES

{Additional context, design decisions, trade-offs, risks}

```markdown
