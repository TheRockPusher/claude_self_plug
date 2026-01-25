# Commit Message Templates

Templates and examples for commit messages with emoji indicators.

## Format Patterns

### Simple Format

```text
<type>: <emoji> <description>
```

### Scoped Format

```text
<type>(<scope>): <emoji> <description>
```

### Multi-line Format

```text
<type>(<scope>): <emoji> <short description>

<detailed explanation if needed>
```

---

## Commit Type Reference

| Type     | Emoji | Use Case                           |
| -------- | ----- | ---------------------------------- |
| feat     | ✨    | New feature or functionality       |
| fix      | 🩹    | Bug fix (minor)                    |
| fix      | 🚑️    | Critical hotfix                    |
| refactor | 🔨    | Code restructure                   |
| perf     | ⚡    | Performance improvement            |
| test     | 🚦    | Test additions or changes          |
| docs     | 📜    | Documentation                      |
| style    | 💅    | Formatting or style                |
| build    | 📦    | Build system or dependencies       |
| ci       | 🦊    | CI configuration                   |
| chore    | 🧹    | Maintenance tasks                  |
| debug    | 🧪    | Debugging changes                  |
| BREAKING | 💣    | Breaking changes                   |

---

## Templates by Type

### feat (New Feature)

**Simple:**

```text
feat: ✨ add user authentication system
```

**With scope:**

```text
feat(auth): ✨ add OAuth2 login support
```

**With body:**

```text
feat(api): ✨ add pagination to user endpoint

Implement cursor-based pagination for GET /users to handle large result
sets efficiently. Default page size is 20 items.
```

### fix (Bug Fix)

**Minor fix:**

```text
fix: 🩹 correct null pointer in login handler
```

**Critical hotfix:**

```text
fix: 🚑️ prevent data loss on concurrent save
```

**With scope:**

```text
fix(cache): 🩹 prevent race condition in TTL refresh
```

### refactor (Code Restructure)

```text
refactor: 🔨 extract validation utilities
```

```text
refactor(auth): 🔨 consolidate token handling logic
```

### perf (Performance)

```text
perf: ⚡ reduce redundant API calls
```

```text
perf(db): ⚡ add index for user lookup queries
```

### test (Testing)

```text
test: 🚦 add integration tests for checkout flow
```

```text
test(auth): 🚦 improve token validation coverage
```

### docs (Documentation)

```text
docs: 📜 update README with installation steps
```

```text
docs(api): 📜 add endpoint documentation
```

### style (Formatting)

```text
style: 💅 apply prettier formatting
```

```text
style(ui): 💅 fix inconsistent indentation
```

### build (Build System)

```text
build: 📦 upgrade webpack to version 5
```

```text
build(deps): 📦 update express to v4.18
```

### ci (CI/CD)

```text
ci: 🦊 add code quality checks to GitHub Actions
```

```text
ci(deploy): 🦊 configure staging environment
```

### chore (Maintenance)

```text
chore: 🧹 update .gitignore for IDE files
```

```text
chore(deps): 🧹 clean up unused dependencies
```

### BREAKING (Breaking Changes)

**With exclamation mark:**

```text
feat(api)!: 💣 change response format for user endpoint
```

**With footer:**

```text
feat(auth): 💣 replace JWT with OAuth2

Remove deprecated JWT-based authentication in favour of OAuth2 flow.

BREAKING CHANGE: JWT tokens are no longer supported. All clients must
  implement OAuth2 authentication.
```

---

## Scope Examples

Common scopes to use with commit types:

| Scope  | Description                |
| ------ | -------------------------- |
| api    | REST API endpoints         |
| auth   | Authentication system      |
| db     | Database layer             |
| ui     | User interface components  |
| core   | Core business logic        |
| config | Configuration files        |
| deps   | Dependencies               |
| ci     | CI/CD pipeline             |
| docs   | Documentation              |
| test   | Test infrastructure        |

---

## Quick Reference

**Remember:**

- Keep first line under 72 characters
- Use imperative mood ("add" not "added")
- Be concise—no filler words
- Never add signatures or co-author tags
- One logical change per commit
