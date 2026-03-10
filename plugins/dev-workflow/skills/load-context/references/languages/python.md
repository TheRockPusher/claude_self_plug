# Python Development Conventions

## Standards

- **PEP 8** — Style guide (naming, whitespace, line length)
- **PEP 484** — Type hints syntax and semantics
- **PEP 257** — Docstring conventions

## Tooling (Astral Stack)

### Package Management: uv

```bash
uv init project-name            # Create new project
uv add package                  # Add dependency
uv add --dev ruff pytest        # Add dev dependencies
uv remove package               # Remove dependency
uv sync                         # Install from lockfile
uv run script.py                # Run in project environment
uv lock --upgrade-package pkg   # Update specific package
```

Commit `uv.lock` to version control for reproducible builds.

### Linting & Formatting: Ruff

```bash
ruff check .                    # Lint
ruff check --fix                # Auto-fix
ruff format .                   # Format (Black-compatible)
```

Configure in `pyproject.toml` under `[tool.ruff]`. Ruff replaces Black,
isort, flake8, and most linting tools.

### Type Checking: ty

```bash
uv tool install ty@latest       # Install
ty check                        # Check current directory
ty check --watch                # Incremental checking
```

ty is Astral's type checker — 10-100x faster than mypy/Pyright.

## Code Style (PEP 8)

### Imports

```python
# Standard library
import os
from pathlib import Path

# Third-party
import requests

# Local
from .utils import helper
```

### Naming

- `snake_case` for functions, variables, modules
- `PascalCase` for classes
- `UPPER_CASE` for constants
- `_private` prefix for internal use

## Type Hints (PEP 484)

```python
def process(data: list[dict[str, Any]]) -> Result | None:
    ...
```

- Use built-in generics (`list`, `dict`) over `typing` module
- Use `|` for unions over `Union`
- Use `X | None` over `Optional[X]`

### Protocols Over ABCs

Prefer `Protocol` for structural typing over `ABC` for inheritance:

```python
from typing import Protocol

class Readable(Protocol):
    def read(self) -> str: ...

def process(source: Readable) -> None:
    content = source.read()
```

Protocols enable duck typing with static type checking.

## Docstrings (PEP 257)

```python
def fetch_data(url: str, timeout: int = 30) -> dict:
    """Fetch JSON data from a URL.

    Args:
        url: The endpoint to fetch from.
        timeout: Request timeout in seconds.

    Returns:
        Parsed JSON response as a dictionary.

    Raises:
        RequestError: If the request fails.
    """
```

## Data Classes

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Config:
    host: str
    port: int = 8080
```

Use Pydantic for validation and serialization.

## Environment Variables

Use `python-dotenv` for `.env` files:

```python
from dotenv import load_dotenv

load_dotenv()  # Load .env into os.environ
```

Never commit `.env` files. Provide `.env.example` as template.

## Project Structure

```text
project/
├── pyproject.toml
├── uv.lock
├── src/
│   └── package/
│       ├── __init__.py
│       └── module.py
└── tests/
    ├── conftest.py
    └── test_module.py
```

Use `src/` layout to prevent accidental imports from project root.

## Testing

```bash
uv run pytest                   # Run tests
uv run pytest --cov=src         # With coverage
```

- Name files `test_*.py`, functions `test_*`
- Use fixtures in `conftest.py`
- Use `pytest.mark.parametrize` for multiple cases

## pyproject.toml Example

```toml
[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = ["requests>=2.28"]

[dependency-groups]
dev = ["ruff", "pytest", "pytest-cov"]

[tool.ruff]
line-length = 88
target-version = "py311"

[tool.ruff.lint]
select = ["F", "E", "W", "I", "UP", "B", "D"]

[tool.ruff.format]
docstring-code-format = true
```
