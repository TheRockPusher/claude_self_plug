# Validation Levels

## Overview

Implementation validation follows a 5-level hierarchy. Each level must pass
before proceeding to the next.

## Level 1: Syntax & Style (Lint/Format)

**Purpose**: Catch syntax errors, formatting issues, import problems

**Common commands by language:**

| Language              | Command                           |
| --------------------- | --------------------------------- |
| Python                | `ruff check .` or `flake8`        |
| JavaScript/TypeScript | `npm run lint` or `npx eslint .`  |
| Rust                  | `cargo clippy`                    |
| Go                    | `golangci-lint run`               |

**Common failures:**

- Unused imports
- Formatting violations
- Line length exceeded
- Missing trailing commas

**Fix approach**: Run auto-fix if available (`ruff check --fix`, `eslint --fix`),
then address remaining issues manually.

## Level 2: Type Safety

**Purpose**: Catch type mismatches, missing annotations, incorrect function signatures

**Common commands by language:**

| Language   | Command                |
| ---------- | ---------------------- |
| Python     | `mypy .` or `pyright`  |
| TypeScript | `npx tsc --noEmit`     |
| Rust       | `cargo check`          |

**Common failures:**

- Missing type annotations
- Incompatible types
- Incorrect return types
- Optional/None handling

**Fix approach**: Add proper type hints, handle optional values, fix type
mismatches at source.

## Level 3: Unit Tests

**Purpose**: Verify individual functions and classes work correctly in isolation

**Common commands by language:**

| Language              | Command                         |
| --------------------- | ------------------------------- |
| Python                | `pytest` or `python -m pytest`  |
| JavaScript/TypeScript | `npm test` or `npx jest`        |
| Rust                  | `cargo test`                    |
| Go                    | `go test ./...`                 |

**Common failures:**

- Assertion failures
- Missing fixtures
- Import errors in tests
- Mocked dependencies not matching

**Fix approach**:

1. Read test failure output carefully
2. Identify if bug is in implementation or test
3. Fix implementation to match expected behaviour
4. Update test if requirements changed

## Level 4: Integration Tests

**Purpose**: Verify components work together correctly

**Common commands:**

- `pytest tests/integration/`
- `npm run test:integration`
- `cargo test --test integration`

**When N/A**: Mark as N/A if project has no integration tests or feature is
purely isolated.

**Common failures:**

- Database connection issues
- API endpoint misconfigurations
- Missing environment variables
- Race conditions

**Fix approach**:

1. Check environment setup
2. Verify all services running
3. Check test isolation (cleanup between tests)

## Level 5: Manual Validation

**Purpose**: Human verification of user-facing behaviour

**Examples:**

- Start the server and test the new endpoint
- Open the UI and verify the button works
- Run the CLI command and check output format
- Verify error messages are helpful

**Documentation format:**

```markdown
Level 5 (Manual):
1. [step] - [expected result]
2. [step] - [expected result]
```

## Iteration Protocol

When a validation level fails:

```markdown
1. Capture full error output
2. Identify root cause (not symptoms)
3. Make minimal fix
4. Re-run SAME validation command
5. If still failing, analyze new error
6. Repeat until pass
7. Move to next level
```

**Maximum iterations**: 3 per level before asking for user help

## Finding Validation Commands

Search these locations for project-specific commands:

1. **CLAUDE.md** — Often has validation section
2. **Makefile** — `make check`, `make test`, `make lint`
3. **package.json** — `scripts` section
4. **pyproject.toml** — `[tool.pytest]`, `[tool.ruff]`, etc.
5. **.github/workflows/** — CI configuration shows what runs

## Validation Report Format

```markdown
### Validation Results

Level 1 (Lint/Format): `ruff check .` - PASSED
Level 2 (Type Safety): `mypy .` - PASSED (2 iterations)
Level 3 (Unit Tests): `pytest` - PASSED
Level 4 (Integration): N/A (no integration tests)
Level 5 (Manual):
  - Started server, tested /api/users - PASSED
  - Verified error response format - PASSED
```
