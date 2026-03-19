---
name: implement
description: Executes plans from .agents/plans/ or inline feature requests with TodoWrite task tracking and mandatory 5-level validation iteration until all checks pass. Use when the user asks to "implement the plan", "execute the plan", "build this", "/implement", or mentions executing an implementation plan.
argument-hint: [plan-name or feature-description]
allowed-tools: Read, Write, Edit, Grep, Glob, Bash(uv*), Bash(npm*), Bash(node*), Bash(cargo*), Bash(go*), Bash(make*), Bash(markdownlint*), TodoWrite, AskUserQuestion, Skill
context: fork
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

### Phase 0: Load Development Context

**Mandatory first step — always run before anything else:**

Invoke `/load-context` to load universal development principles (YAGNI, KISS,
pure functions, error handling) and language-specific conventions based on
detected project config files. This grounds all implementation decisions in
consistent coding standards before touching any code.

### Phase 0.5: Input Validation

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

### Phase 2: Task Setup (MANDATORY — No Code Before Tasks)

**You MUST create a complete task list with TodoWrite before writing or editing
any code.** This is non-negotiable regardless of input mode. No implementation
work begins until every task is registered and the first is marked
`in_progress`.

The reason this matters: without upfront task decomposition, implementation
drifts, steps get skipped, and progress becomes invisible to the user. A clear
task list keeps both you and the user aligned on scope and progress throughout
the entire implementation.

**From a plan file — extract tasks from "STEP-BY-STEP TASKS":**

```text
Example plan tasks:
### CREATE src/services/auth.py
### UPDATE src/routes/api.py
### ADD tests/test_auth.py

Becomes TodoWrite entries:
1. Create src/services/auth.py
2. Update src/routes/api.py
3. Add tests/test_auth.py
4. Run validation commands
```

**From inline instructions — decompose the request into discrete tasks:**

1. Analyse the user's request and break it into atomic, ordered steps
2. Include file creation, modification, test writing, and validation as
   separate tasks
3. If the decomposition is non-obvious, use AskUserQuestion to confirm the
   task list with the user before proceeding

**Then, for both modes:**

- Call TodoWrite with ALL tasks at once so the full scope is visible upfront
- Mark the first task as `in_progress`
- Only then proceed to Phase 3

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
- Use TodoWrite to mark task `completed`
- Use TodoWrite to mark next task `in_progress`

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
