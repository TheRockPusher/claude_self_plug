---
name: brainstorm
description: This skill should be used when the user asks to "brainstorm", "discuss an idea", "explore options", "think through a problem", "/brainstorm", or mentions wanting to talk through a development idea, issue, or new functionality before planning. Facilitates highly interactive dialogue to reach a simple, YAGNI-compliant solution written to .agents/brainstorms/.
argument-hint: <topic> [--ref <previous-brainstorm>...]
allowed-tools: Read, Grep, Glob, Bash(git ls-files*), AskUserQuestion, Write
context: fork
model: opus
---

# Brainstorm

Facilitate deep, interactive dialogue with the user to explore a development
problem, issue, or new functionality. Through iterative questioning and
discussion, converge on a simple, well-reasoned solution.

**Core Philosophy**: Talk first, solve later. The goal is mutual understanding
and a solution that fits all parameters while remaining simple.

## Output Location

Write final brainstorm to `.agents/brainstorms/{kebab-case-topic}.md`

Use the template in `references/output-template.md`.

## Process

### Phase 1: Problem Discovery

**Start with open exploration.** Ask one focused question at a time.

Initial questions to understand the space:

1. "What problem are you trying to solve?" (if not already clear)
2. "What triggered this? Is there a specific pain point?"
3. "Who or what is affected by this problem?"

**Use AskUserQuestion liberally.** Short, focused questions beat long lists.

### Phase 2: Constraint Gathering

Explore constraints through targeted questions. Cover all relevant areas:

| Area | Example Questions |
| --- | --- |
| Performance | "Are there latency or throughput requirements?" |
| Security | "What data sensitivity level? Auth requirements?" |
| Maintainability | "Who will maintain this? What's their skill level?" |
| Scalability | "Expected load now vs future?" |
| Integration | "What existing systems must this work with?" |
| Timeline | "Any deadlines or dependencies?" |
| Budget | "Resource constraints? Infrastructure limits?" |

**Skip irrelevant areas.** A CLI tool doesn't need scalability questions.

### Phase 3: Solution Exploration

Present options as they emerge. For each option:

- Describe the approach in plain terms
- List concrete trade-offs (not abstract pros/cons)
- Rate complexity: Simple / Moderate / Complex
- Note alignment with constraints

**Ask after each option:**

- "Does this direction resonate?"
- "What concerns come to mind?"
- "Is there something I'm missing?"

### Phase 4: Refinement Loop

Iterate until convergence:

1. Present refined solution based on feedback
2. Ask: "What would make this simpler?"
3. Challenge complexity: "Do we really need X?"
4. Validate against constraints: "Does this meet requirement Y?"

**Apply design principles** from `references/principles.md`:

- YAGNI: Remove features not immediately needed
- KISS: Prefer boring, proven approaches
- Start small: What's the minimum viable solution?

### Phase 5: Solution Confirmation

Before writing, confirm the solution:

```text
"Here's what I understand:

Problem: {summary}
Constraints: {list}
Solution: {description}

Does this capture it? Anything to adjust?"
```

**Only proceed to writing after explicit confirmation.**

### Phase 6: Write Brainstorm Document

Create `.agents/brainstorms/{topic}.md` following the output template.

The document should be:

- Readable by humans (primary audience)
- Ingestible by `/plan` skill for implementation
- Complete enough to revisit months later

## Referencing Previous Brainstorms

**Only load previous brainstorms when explicitly requested via `--ref` argument.**

Example invocations:

- `/brainstorm auth-refactor` — fresh brainstorm, no references
- `/brainstorm auth-refactor --ref api-design` — load `api-design.md` as context
- `/brainstorm auth-refactor --ref api-design --ref db-schema` — load multiple

When `--ref` is provided:

1. Read each referenced file from `.agents/brainstorms/{name}.md`
2. Extract relevant decisions and constraints
3. Note how the new brainstorm relates (extends, supersedes, conflicts)
4. Reference these in the output document's "Previous Decisions" section

If user asks to "see previous brainstorms" without `--ref`:

```bash
ls .agents/brainstorms/
```

Then ask which ones to load.

## Conversational Style

**Be curious, not prescriptive.** The user knows their domain.

**One question at a time.** Let conversations flow naturally.

**Summarise frequently.** "So far I understand X, Y, Z. Correct?"

**Challenge assumptions.** "Why does it need to be real-time?"

**Suggest simplifications.** "What if we started without feature X?"

## Output Report

After writing the brainstorm document:

```text
### Brainstorm Complete

**Topic**: {topic}
**File**: .agents/brainstorms/{filename}.md
**Solution**: {one-sentence summary}

Ready for `/plan {filename}` when you want to proceed.
```

## Guidelines

- Never rush to solutions — explore the problem space first
- Validate every assumption with the user
- Simpler is better; complexity requires justification
- Document rejected options (they inform future decisions)
- The brainstorm document is the deliverable, not code
