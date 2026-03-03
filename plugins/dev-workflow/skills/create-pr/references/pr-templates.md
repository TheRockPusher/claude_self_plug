# PR Description Templates

Three-tier template system inspired by PR templates from React, Kubernetes,
Angular, Svelte, Ruff, Tailwind CSS, and other major open source projects.

Select the template tier based on change complexity.

---

## Template Selection Guide

| Criteria                        | Template  |
| ------------------------------- | --------- |
| Single-purpose, <100 lines      | Minimal   |
| Most PRs, standard features     | Standard  |
| Breaking changes, large features| Full      |
| Multi-subsystem changes          | Full      |
| New public API surface           | Full      |

---

## Tier 1: Minimal Template

For focused, single-purpose changes. Inspired by React, Ruff, and
Tailwind CSS which prove that two sections can be enough for
high-quality projects.

```markdown
## Summary

<!-- Explain the motivation for this change. What problem does it
solve? The diff shows what changed; explain why. -->

## Test Plan

<!-- How was this tested? Include exact commands run, their output,
or screenshots/videos for UI changes. -->
```

---

## Tier 2: Standard Template

For most pull requests. Covers the essentials without overhead.

```markdown
## Summary

<!-- Explain the motivation. What existing problem does this solve? -->

## Changes

<!-- Concise bullet-point list of what changed -->

-

## Test Plan

<!-- How was this tested? Include exact commands, output, or
screenshots. -->

## Related Issues

<!-- Use closing keywords: Fixes #123 / Closes #456 / Related to
#789 -->
```

---

## Tier 3: Comprehensive Template

For breaking changes, large features, multi-subsystem changes, or
new public API surface. Inspired by Kubernetes, Angular, and Home
Assistant.

```markdown
## Summary

<!-- Explain the motivation and what problem this solves -->

## Type of Change

<!-- Select one -->

- [ ] Bug fix (non-breaking)
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update
- [ ] Refactoring
- [ ] Performance improvement
- [ ] CI/Build

## Breaking Changes

<!-- If applicable: what breaks, migration path, and why.
Remove this section if not applicable. -->

## Changes

<!-- Bullet-point list of what changed -->

-

## Test Plan

<!-- How was this tested? Include exact commands, output, or
screenshots/videos. -->

## Related Issues

<!-- Fixes #123 / Closes #456 / KEP: link -->

## Checklist

- [ ] Tests added or updated and passing
- [ ] Documentation updated (if applicable)
- [ ] No commented-out code
- [ ] Lint and format checks pass
```

---

## PR Title Convention

### Format

```text
<type>(<optional-scope>): <emoji> <short description>
```

### Rules

- Keep under 70 characters total
- Use imperative mood ("add" not "added")
- No trailing period
- Capitalise first word after emoji
- One type per PR

### Title Emoji Reference

| Type     | Emoji | Use Case                     |
| -------- | ----- | ---------------------------- |
| feat     | ✨     | New feature or functionality |
| fix      | 🩹     | Bug fix (minor)              |
| fix      | 🚑️     | Critical hotfix              |
| refactor | 🔨     | Code restructure             |
| perf     | ⚡     | Performance improvement      |
| test     | 🚦     | Test additions or changes    |
| docs     | 📜     | Documentation                |
| style    | 💅     | Formatting or style          |
| build    | 📦     | Build system or dependencies |
| ci       | 🦊     | CI configuration             |
| chore    | 🧹     | Maintenance tasks            |
| feat!    | 💣     | Breaking changes             |

### Title Examples

**Good:**

- `feat(auth): ✨ add OAuth2 login flow`
- `fix(api): 🩹 resolve race condition in cache refresh`
- `refactor: 🔨 extract validation utilities`
- `feat(api)!: 💣 change response format for user endpoint`
- `docs: 📜 update README with installation steps`

**Avoid:**

- `Update code` (vague, no type)
- `fix #7123` (no description)
- `Added new feature` (past tense, no type)
- `WIP: stuff` (not ready for PR)

---

## Description Writing Guidelines

### Summary Section

The summary is the most important section. It answers **why** this
change exists.

**Structure:**

1. State the problem or motivation (1-2 sentences)
2. Describe the solution approach (1-2 sentences)
3. Note any trade-offs or alternatives considered (optional)

**Good example:**

```markdown
## Summary

User login fails silently when the OAuth provider returns a
malformed token. This causes a blank screen with no error message,
leading to support tickets.

Add token validation before the authentication handshake and
surface a user-friendly error message when validation fails.
```

**Bad example:**

```markdown
## Summary

Fixed the login bug.
```

### Changes Section

Use concise bullet points. Each bullet describes one logical change.

**Good:**

```markdown
## Changes

- Add `validateToken()` to auth middleware
- Surface error toast when token validation fails
- Add unit tests for malformed token scenarios
```

**Bad:**

```markdown
## Changes

- Changed auth.ts
- Changed login.tsx
- Changed test file
```

### Test Plan Section

Provide evidence that the change works. Acceptable evidence includes:

- Exact commands run and their output
- Screenshots or screen recordings for UI changes
- Links to CI runs
- Manual test steps with expected results

React warns: "If you leave this empty, your PR will very likely
be closed."

---

## Issue Reference Syntax

### GitHub

Use closing keywords in the Related Issues section:

| Keyword     | Effect                      |
| ----------- | --------------------------- |
| Fixes #N    | Closes issue when PR merges |
| Closes #N   | Closes issue when PR merges |
| Resolves #N | Closes issue when PR merges |
| Related #N  | Links without closing       |
| Refs #N     | Links without closing       |
| Depends #N  | Indicates dependency        |

### GitLab

GitLab uses similar keywords but also supports project-scoped
references:

| Keyword      | Effect                      |
| ------------ | --------------------------- |
| Fixes #N     | Closes issue when MR merges |
| Closes #N    | Closes issue when MR merges |
| Resolves #N  | Closes issue when MR merges |
| Related to #N| Links without closing       |
| group/project#N | Cross-project reference  |

GitLab also supports `/close #N` quick actions in the MR
description body.
