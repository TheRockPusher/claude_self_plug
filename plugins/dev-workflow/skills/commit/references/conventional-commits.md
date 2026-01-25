# Conventional Commits Reference

Reference documentation for the Conventional Commits specification.

## Overview

Conventional Commits is a specification for adding human and machine readable
meaning to commit messages. It provides a lightweight convention that ties into
Semantic Versioning (SemVer) and enables automated changelog generation.

---

## Commit Message Structure

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Components

| Component   | Required | Description                              |
| ----------- | -------- | ---------------------------------------- |
| type        | Yes      | Nature of the change (feat, fix, etc.)   |
| scope       | No       | Part of codebase affected (auth, ui)     |
| description | Yes      | Short summary in imperative mood         |
| body        | No       | Detailed explanation after blank line    |
| footer(s)   | No       | Metadata following git trailer format    |

---

## Commit Types

### Primary Types (SemVer Impact)

| Type | Version Bump | Purpose                        |
| ---- | ------------ | ------------------------------ |
| feat | MINOR        | New feature or functionality   |
| fix  | PATCH        | Bug fix in the codebase        |

### Additional Types (Angular Convention)

| Type     | Purpose                                    |
| -------- | ------------------------------------------ |
| perf     | Performance improvements                   |
| refactor | Code restructure without behaviour change  |
| style    | Formatting and cosmetic changes            |
| test     | Adding or improving tests                  |
| docs     | Documentation updates                      |
| build    | Build system or dependency changes         |
| ci       | CI/CD pipeline configuration               |
| chore    | Administrative maintenance tasks           |
| revert   | Undo previous commits                      |

---

## Breaking Changes

Breaking changes trigger a MAJOR version bump in SemVer.

### Method 1: Exclamation Mark

Append `!` after type (and scope if present):

```text
feat!: remove deprecated authentication API
feat(api)!: change response format for user endpoint
```

### Method 2: Footer Token

Include `BREAKING CHANGE:` in the footer section:

```text
feat: migrate to OAuth2 authentication

BREAKING CHANGE: JWT tokens are no longer supported.
  All clients must implement OAuth2 flow.
```

Note: `BREAKING-CHANGE` (hyphenated) is synonymous with `BREAKING CHANGE`.

---

## Footer Conventions

Footers appear one blank line after the body and follow git trailer format.

### Structure

```text
Token: <value>
```

Or with `#` separator for issue references:

```text
Token #<value>
```

### Common Footer Tokens

| Token          | Purpose                  | Example                       |
| -------------- | ------------------------ | ----------------------------- |
| BREAKING CHANGE| Indicate breaking change | `BREAKING CHANGE: API removed`|
| Closes         | Close an issue           | `Closes: #123`                |
| Fixes          | Fix an issue             | `Fixes: #456`                 |
| Refs           | Reference related issues | `Refs: #789, #101`            |
| Reviewed-by    | Record reviewer          | `Reviewed-by: @alice`         |
| Co-Authored-By | Credit co-authors        | `Co-Authored-By: Name <email>`|

### Footer Rules

- Must appear after a blank line following the body
- Token uses word-characters and hyphens (no spaces)
- Separator is either `:` (colon-space) or `#` (space-hash)
- Values may span multiple lines (indent continuations)

---

## Description Guidelines

- Use imperative mood: "add" not "added" or "adds"
- Start with lowercase letter
- No period at the end
- Keep under 72 characters (50 recommended)
- Be specific about what changed

**Good examples:**

- `add user authentication endpoint`
- `fix null pointer in login handler`
- `update README with installation steps`

**Avoid:**

- `Added feature` (past tense)
- `Adding feature` (present participle)
- `Feature added.` (period, passive)

---

## Body Guidelines

- Start one blank line after description
- Explain **what** and **why**, not how
- Wrap lines at 72 characters
- May contain multiple paragraphs
- Use bullet points for lists

---

## Examples

### Simple (Type Only)

```text
docs: correct spelling in CHANGELOG
```

### With Scope

```text
feat(auth): add OAuth2 login support
```

### With Body

```text
fix(cache): prevent race condition in TTL refresh

The previous implementation allowed multiple threads to refresh the same
cache entry simultaneously, leading to inconsistent state. Add mutex lock
around refresh operation.
```

### With Footer

```text
feat(api): add pagination to user endpoint

Implement cursor-based pagination for the GET /users endpoint to handle
large result sets efficiently.

Closes: #234
Refs: #189
```

### Breaking Change with Body and Footers

```text
feat(auth)!: replace JWT with OAuth2

Remove deprecated JWT-based authentication in favour of OAuth2 flow.
This requires all clients to update their authentication implementation.

Migration steps:
- Update authentication headers
- Implement OAuth2 handshake
- Remove JWT token handling

BREAKING CHANGE: JWT tokens are no longer supported. All clients must
  implement OAuth2 authentication. See docs/migration/auth-v2.md for
  the complete migration guide.
Reviewed-by: @security-team
Closes: #89
```

---

## Semantic Versioning Correlation

| Commit Type     | Version Impact   |
| --------------- | ---------------- |
| fix             | PATCH (0.0.X)    |
| feat            | MINOR (0.X.0)    |
| BREAKING CHANGE | MAJOR (X.0.0)    |
| All other types | No version bump  |
