# Design Principles for Brainstorming

Reference these principles when evaluating solutions during brainstorming.

---

## Core Principles

### YAGNI (You Ain't Gonna Need It)

**Definition**: Do not add functionality until it is necessary.

**Application**:

- Question every feature: "Do we need this right now?"
- Remove speculative requirements
- Build for today's known needs, not tomorrow's imagined ones
- If a feature "might be useful later", leave it out

**Challenge phrases**:

- "What if we didn't include X?"
- "Can we add this later without major rework?"
- "Is this solving a real problem or an imagined one?"

### KISS (Keep It Simple, Stupid)

**Definition**: Prefer simple solutions over complex ones.

**Application**:

- Choose boring, proven technologies over novel ones
- Prefer explicit code over clever abstractions
- Reduce moving parts and dependencies
- If you can explain it in one sentence, it's probably simple enough

**Challenge phrases**:

- "What's the simplest thing that could work?"
- "Is there a way to do this with less?"
- "Would a junior developer understand this?"

### Start Small

**Definition**: Begin with the minimum viable solution and iterate.

**Application**:

- Identify the core value and build only that first
- Ship something small, get feedback, then expand
- Avoid big-bang releases
- Treat v1 as a learning exercise, not the final product

**Challenge phrases**:

- "What's the smallest useful version?"
- "Can we validate the idea before building everything?"
- "What can we cut and still deliver value?"

---

## Secondary Principles

### Worse Is Better

Sometimes a solution that is simpler but slightly less correct or complete
wins over a complex, "perfect" solution.

**When to apply**:

- When simplicity enables faster iteration
- When "good enough" meets actual user needs
- When complexity costs exceed marginal benefits

### Make It Work, Make It Right, Make It Fast

Solve problems in this order:

1. **Work**: Get a functional solution
2. **Right**: Refactor for clarity and correctness
3. **Fast**: Optimise only when needed

**Implication**: Don't optimise during brainstorming. Focus on "work" first.

### Separation of Concerns

Each component should have one clear responsibility.

**Application**:

- Can you describe this component's job in one sentence?
- If you change X, should Y need to change too?
- Are boundaries between components clear?

### Fail Fast

Detect and surface errors as early as possible.

**Application**:

- Validate inputs at boundaries
- Make invalid states unrepresentable
- Prefer explicit errors over silent failures

---

## Trade-off Framework

When comparing solutions, evaluate against these dimensions:

| Dimension | Questions |
| --------- | --------- |
| Complexity | How many moving parts? How hard to understand? |
| Flexibility | How easy to change later? What's locked in? |
| Risk | What could go wrong? How bad would it be? |
| Dependencies | What do we rely on? Are they stable? |
| Maintainability | Who maintains this? What's their skill level? |
| Time to Value | How quickly can we deliver something useful? |

### Complexity Budget

Every solution has a complexity budget. Spend it wisely:

- **Essential complexity**: Inherent to the problem, cannot be removed
- **Accidental complexity**: Introduced by our solution, can be minimised

Ask: "Is this complexity essential or accidental?"

---

## Anti-patterns to Avoid

### Premature Optimisation

"We should use X for performance" — before measuring.

**Counter**: Measure first. Optimise only proven bottlenecks.

### Resume-Driven Development

Choosing technologies because they look good on a resume.

**Counter**: Use boring technology that solves the problem.

### Golden Hammer

"When all you have is a hammer, everything looks like a nail."

**Counter**: Choose tools that fit the problem, not problems that fit tools.

### Second System Effect

Overengineering the second version because the first was too simple.

**Counter**: Apply the same simplicity principles to every iteration.

### Cargo Culting

Copying patterns without understanding why they exist.

**Counter**: Understand the "why" before adopting a pattern.

---

## Decision Heuristics

Quick checks when evaluating options:

1. **Reversibility**: Can we undo this decision easily?
   - Reversible → bias toward action
   - Irreversible → bias toward caution

2. **Blast radius**: If this fails, how much breaks?
   - Small blast → experiment freely
   - Large blast → invest in validation

3. **Learning value**: Will this teach us something?
   - High learning → favours doing
   - Low learning → favour simpler path

4. **Maintenance burden**: Who pays the ongoing cost?
   - High burden → needs strong justification
   - Low burden → acceptable for small gains
