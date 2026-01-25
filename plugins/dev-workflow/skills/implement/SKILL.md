---
name: Implement
description: This skill should be used when the user asks to "implement the plan", "execute the plan", "implement this feature", "build this", "code this", or wants to execute an implementation plan or feature request with validation.
---

# Implement

Execute an implementation plan or feature request with task tracking and
mandatory validation iteration.

## Input Modes

**Mode 1: Plan File**
Read and execute a plan from `.agents/plans/`.

**Mode 2: Inline Instructions**
When no plan file exists, gather context and implement directly from user instructions.

## Process

### Phase 0: Input Validation

**If plan file provided:**

1. Read the ENTIRE plan file
2. Verify these sections exist (ask user if missing):
   - CONTEXT REFERENCES (Mandatory Reading)
   - STEP-BY-STEP TASKS
   - VALIDATION COMMANDS
3. If anything is unclear, use AskUserQuestion before proceeding

**If inline instructions:**

1. Read CLAUDE.md or AGENTS.md if present
2. Understand project conventions
3. Identify relevant patterns in codebase
4. Proceed with implementation

### Phase 1: Context Loading

**Read ALL files listed in "Mandatory Reading" section before any implementation.**

For each file reference:

- Read the specified line ranges
- Understand the patterns to follow
- Note imports, naming conventions, error handling

This ensures pattern consistency across implementation.

### Phase 2: Task Setup

**Create tasks from "STEP-BY-STEP TASKS" section using TaskCreate:**

```text
Example plan tasks:
### CREATE src/services/auth.py
### UPDATE src/routes/api.py
### ADD tests/test_auth.py

Becomes tasks:
1. Create src/services/auth.py
2. Update src/routes/api.py
3. Add tests/test_auth.py
4. Run validation commands
```

Use TaskUpdate to mark first task as `in_progress` before starting.

### Phase 3: Execute Tasks

For EACH task in order:

#### a. Read context

- Re-read pattern references from plan
- Read existing files if modifying

#### b. Implement

- Follow specifications exactly
- Mirror patterns from mandatory reading
- Maintain consistency with codebase

#### c. Verify and update

- Check syntax after changes
- Use TaskUpdate to mark task `completed`
- Use TaskUpdate to mark next task `in_progress`

### Phase 4: Testing

After implementation tasks:

- Create test files from plan
- Implement all specified test cases
- Run tests, fix failures before proceeding

### Phase 5: Validation (MANDATORY ITERATION)

**CRITICAL**: This phase MUST complete successfully before finishing.

Execute ALL validation commands from plan in order. See
`references/validation-levels.md` for details.

**Validation Iteration Loop:**

For EACH validation command:

1. **Run the command** — Execute exactly as specified
2. **Check result**
   - PASS: Continue to next level
   - FAIL: Enter fix iteration loop
3. **Fix iteration loop** (if failed)
   - Analyze error output carefully
   - Identify root cause (not just symptoms)
   - Make necessary fixes using Edit tool
   - Re-run the SAME validation command
   - Repeat until PASS
4. **Only proceed when ALL validations pass**

**If stuck after 3 iterations:**

- Use AskUserQuestion for user guidance
- Document the blocker in completion report
- Do NOT mark implementation as complete

### Phase 6: Documentation Check

**If implementation changes user-facing behaviour, update:**

- `README.md` - Usage, setup, features
- `CLAUDE.md` - AI instructions, commands, conventions
- `.agents/PRD.md` - Requirements status

Skip if changes are internal-only.

### Phase 7: Completion Report

**Only generate after ALL validations pass.**

```text
### Summary

- Tasks completed (use TaskList to review)
- Files created/modified (with line counts)
- Documentation updated (if any)

### Validation Results

Level 1 (Lint/Format): [command] - PASSED
Level 2 (Type Safety): [command] - PASSED
Level 3 (Unit Tests): [command] - PASSED
Level 4 (Integration): [command] - PASSED / N/A
Level 5 (Manual): [steps] - COMPLETED

### Implementation Metrics

- Total tasks: X
- Files changed: Y
- Validation iterations: Z

### Next Steps

Ready for `/commit` (all validations passed)
OR
Blocked (document why)
```

## Guidelines

- **Doubts?** Ask user, don't assume
- **Deviations?** Explain why in report
- **Failures?** Fix before marking complete
- **Never skip** validation commands
