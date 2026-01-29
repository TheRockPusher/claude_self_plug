# Universal Development Principles

## Core Rules

1. **Never assume — always ask.** When in doubt about requirements,
   implementation, or decisions, ask the user. Never guess.

2. **Use ripgrep.** Always use `rg` instead of `grep` or `find` for searching.

3. **Check for task runners.** If `Makefile` or `justfile` exists, read it
   and prefer its commands over manual commands.

4. **Test everything.** Write tests before marking work complete. Target 80%+
   coverage.

## Design Principles

### YAGNI (You Aren't Gonna Need It)

- Build only what's needed now
- No speculative features or "just in case" abstractions
- Delete unused code

### KISS (Keep It Simple)

- Straightforward over clever
- Readable over brief
- If it's hard to explain, simplify it

### DRY — Applied Wisely

- Extract only after 3+ repetitions
- Premature abstraction is worse than duplication

### Be Concise

- Write as simply as you can
- Short and explicit

## Code Quality

### Pure & Reproducible

- Minimize state mutation
- Same inputs → same outputs
- Isolate I/O and statefulness at boundaries

### Single Responsibility

- Each function does one thing
- Each module has one reason to change

### Explicit Over Implicit

- Make dependencies visible
- Configuration over convention when clarity matters

## Error Handling

- Fail fast on programmer errors
- Handle expected failures gracefully
- Actionable error messages
- Never swallow exceptions

## Testing

- Test behaviour, not implementation
- Focus on public interfaces
- 80%+ coverage required

## Documentation

- Code should be self-documenting
- Comments explain "why", not "what"
- Delete stale documentation

## Refactoring

- Understand before changing
- Small, incremental changes
- Never refactor and add features simultaneously
