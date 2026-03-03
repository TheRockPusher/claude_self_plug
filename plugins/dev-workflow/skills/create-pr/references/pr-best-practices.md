# PR Best Practices

Synthesised from PR templates and contribution guidelines of 14 major
open source projects: React, Kubernetes, Angular, Svelte, Electron,
Home Assistant, Ruff, Tailwind CSS, Deno, Apache Airflow, NixOS,
Flutter, Astro, and LangChain.

---

## Universal Principles

### 1. The "Why" Matters More Than the "What"

The diff shows what changed. The description must explain **why** the
change exists and what problem it solves.

React's template explicitly states: "Explain the motivation for making
this change. What existing problem does the pull request solve?"

### 2. Test Evidence Is Non-Negotiable

Every major project requires test plan documentation. React warns:
"If you leave this empty, your PR will very likely be closed."

Acceptable evidence:

- Exact commands run and their output
- Screenshots or screen recordings for UI changes
- Links to passing CI runs
- Manual test steps with expected results

### 3. Keep PRs Small and Focused

Aim for 200-400 lines of change. If the PR title cannot be written
as a single conventional commit, the PR is probably too large.

Signs a PR should be split:

- Multiple change types (feat + fix)
- Different subsystems touched
- Unrelated bug fixes in same diff
- More than 3 files with substantial changes in unrelated areas

### 4. Self-Review Before Requesting Review

Read the diff before submitting. Remove:

- Debug code and `console.log` statements
- Commented-out blocks
- Unrelated formatting changes
- TODO comments without issue references

---

## Section Frequency Across OSS Projects

How often each section appears in the 14 surveyed templates:

| Section             | Frequency | Projects Using It           |
| ------------------- | --------- | --------------------------- |
| Summary/Description | 93%       | React, K8s, Angular, Ruff   |
| Test Plan           | 71%       | React, Ruff, Tailwind, Deno |
| Checklist           | 57%       | Angular, Svelte, Flutter    |
| Related Issues      | 50%       | K8s, Angular, Flutter       |
| Type of Change      | 36%       | K8s, Angular, Home Asst.    |
| Breaking Changes    | 29%       | Angular, Home Assistant     |
| Release Notes       | 21%       | K8s, Electron, NixOS        |
| Docs Impact         | 21%       | Astro, Flutter              |

**Takeaway**: Summary + Test Plan is the universal minimum. Add
sections only when they provide value for the specific change.

---

## Common Anti-Patterns

### Vague Descriptions

```markdown
## Summary
Fixed the bug.
Updated some files.
Made improvements.
```

These tell the reviewer nothing. Always specify what problem existed,
what the fix is, and why this approach was chosen.

### File-List Changes

```markdown
## Changes
- Changed auth.ts
- Changed login.tsx
- Changed package.json
```

Listing files without explaining the logical changes is useless.
Describe what each change accomplishes.

### Empty Test Plans

```markdown
## Test Plan
N/A
```

If the change cannot be tested, explain why. Otherwise, provide
evidence. An empty test plan signals the change was not verified.

### Kitchen-Sink PRs

PRs that mix features, bug fixes, refactoring, and style changes.
Each logical change deserves its own PR for clean git history and
easier review.

### Missing Issue References

When a PR fixes a known issue, always reference it. This creates
traceability and automatically closes issues when the PR merges.

---

## Template-Specific Patterns from Major Projects

### React (Minimal Philosophy)

Only two sections: Summary and "How did you test this change?"
Emphasises motivation over mechanics. Warns PRs without test
evidence will be closed.

### Kubernetes (Label-Driven)

Uses bot commands (`/kind bug`, `/kind feature`) for classification.
Includes explicit release-note blocks and KEP references for
significant changes.

### Angular (Checkbox Classification)

Checkbox-based type selection. Current vs. new behaviour framing.
Explicit breaking change gate with yes/no checkboxes.

### Svelte (Conventional Commits)

Explicitly mandates conventional commit prefixes in PR titles:
`feat:`, `fix:`, `chore:`, `docs:`. Requires changeset for code
changes.

### Home Assistant (Breaking Changes First)

Breaking change section comes **first** in the template, before
the proposed change. Requires contributors to review 2 other open
PRs. Includes AI-generated code disclosure clause.

### Deno (Invisible Guidance)

All instructions are HTML comments that disappear in the rendered
view. Includes explicit good and bad title examples.

---

## Draft PRs

Use draft PRs when:

- Work is in progress and not ready for review
- Early feedback is needed on approach
- CI should run but formal review is premature

Mark as ready for review only when:

- All tests pass
- Self-review is complete
- Description is finalised

---

## Reviewer-Friendly PRs

A reviewer-friendly PR:

1. Has a clear, conventional title under 70 characters
2. Explains the motivation in the first paragraph
3. Lists changes as concise bullet points
4. Provides test evidence
5. References related issues
6. Is small enough to review in one sitting (< 400 lines)
7. Has no unrelated changes mixed in
8. Passes CI before review is requested
