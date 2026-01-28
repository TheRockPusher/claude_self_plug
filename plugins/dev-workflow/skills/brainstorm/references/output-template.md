# Brainstorm Output Template

## Usage

Reference this template when writing brainstorm documents to
`.agents/brainstorms/`.

---

## Template

````markdown
# Brainstorm: {Topic Title}

> Generated: {date}
> Status: Ready for /plan | Needs revision | Exploratory

## Problem Statement

{Clear, refined description of the problem being solved. Include:
- What triggered this exploration
- Who/what is affected
- Why it matters}

## Constraints & Parameters

### Hard Constraints (Non-negotiable)

- {constraint}: {reason}
- {constraint}: {reason}

### Soft Constraints (Preferences)

- {preference}: {flexibility level}
- {preference}: {flexibility level}

### Out of Scope

- {explicitly excluded item}
- {explicitly excluded item}

## Context

### Related Systems

- {system/component}: {how it relates}

### Previous Decisions

- {reference to prior brainstorm or decision, if any}

### Assumptions

- {assumption}: {validation status}

## Options Explored

### Option 1: {Name}

**Approach**: {description}

**Trade-offs**:
| Aspect | Assessment |
|--------|------------|
| Complexity | Simple / Moderate / Complex |
| Performance | {impact} |
| Maintainability | {impact} |
| Security | {impact} |

**Verdict**: Chosen / Rejected / Deferred

**Reason**: {why this verdict}

### Option 2: {Name}

{Same structure as Option 1}

### Option N: {Name}

{Same structure as Option 1}

## Chosen Solution

### Summary

{One paragraph describing the solution in plain terms}

### Key Decisions

1. **{Decision}**: {rationale}
2. **{Decision}**: {rationale}
3. **{Decision}**: {rationale}

### How It Works

{Describe the solution at a conceptual level:
- Main components or steps
- Data flow or user flow
- Integration points}

### Simplifications Made

{List features or complexity intentionally omitted:
- {omission}: can add later if needed
- {omission}: YAGNI rationale}

## Rationale

### Why This Solution

{Explain why the chosen solution best fits the constraints:
- Alignment with hard constraints
- Trade-off decisions on soft constraints
- Simplicity justification}

### Why Not Alternatives

{Brief note on why rejected options didn't make the cut}

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| {risk} | Low/Med/High | Low/Med/High | {strategy} |

## Open Questions

{Questions that surfaced but weren't resolved:
- {question}: {context}
- {question}: {context}}

## Next Steps

### Ready for Implementation

{If status is "Ready for /plan":}

To proceed with implementation:

```bash
/plan {this-brainstorm-topic}
```

**Implementation hints**:

- Start with: {first component}
- Key pattern to follow: {reference}
- Estimated complexity: Low / Medium / High

### Needs Further Discussion

{If status is "Needs revision":}

Before proceeding, resolve:

1. {blocker}
2. {blocker}

---

## Discussion Log (Optional)

{Condensed notes from the brainstorming session:

- Key insights that emerged
- Pivotal moments in the discussion
- User preferences expressed}

````

---

## Guidelines for Writing

### Problem Statement

- Be specific, not vague
- Include the "why" behind the problem
- Mention who raised this or what triggered it

### Options Explored

- Document ALL seriously considered options
- Even rejected options have value for future reference
- Be honest about trade-offs

### Chosen Solution

- Describe at conceptual level, not implementation detail
- Focus on "what" and "why", not "how to code it"
- Make simplifications explicit

### Next Steps

- Always include clear path to `/plan`
- Note any prerequisites or dependencies
- Estimate complexity to set expectations

## Integration with /plan

The brainstorm document should provide `/plan` with:

1. **Clear scope**: What to build, what not to build
2. **Constraints**: Non-negotiables the plan must respect
3. **Context**: Systems and patterns to consider
4. **Direction**: The chosen approach to implement

The `/plan` skill will read this document and translate it into
actionable implementation tasks.
