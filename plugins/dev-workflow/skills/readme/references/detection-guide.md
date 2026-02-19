# Project Metadata Detection Guide

Patterns and file locations for auto-detecting project metadata across
language ecosystems.

## Package Manifests

Scan these files to extract name, version, description, license, author,
and dependencies.

| Ecosystem | File | Key Fields |
| --- | --- | --- |
| Node.js | `package.json` | name, version, description, license, author, scripts, bin |
| Python | `pyproject.toml` | project.name, project.version, project.description, project.license |
| Python (legacy) | `setup.py`, `setup.cfg` | name, version, description, license |
| Rust | `Cargo.toml` | package.name, package.version, package.description, package.license |
| Go | `go.mod` | module path (name), go version |
| Ruby | `*.gemspec`, `Gemfile` | name, version, summary, license |
| Java/Kotlin | `pom.xml`, `build.gradle`, `build.gradle.kts` | groupId, artifactId, version |
| C# | `*.csproj`, `*.sln` | PackageId, Version, Description |
| Elixir | `mix.exs` | app, version, description |
| PHP | `composer.json` | name, description, license, type |
| Swift | `Package.swift` | name, products |
| Dart/Flutter | `pubspec.yaml` | name, version, description |

## Language Detection

Determine the primary language from file extensions and config files.

### By File Extension (count occurrences)

| Language | Extensions |
| --- | --- |
| JavaScript/TypeScript | `.js`, `.jsx`, `.ts`, `.tsx`, `.mjs`, `.cjs` |
| Python | `.py`, `.pyx`, `.pyi` |
| Rust | `.rs` |
| Go | `.go` |
| Java | `.java` |
| Kotlin | `.kt`, `.kts` |
| C | `.c`, `.h` |
| C++ | `.cpp`, `.cc`, `.cxx`, `.hpp`, `.hh` |
| C# | `.cs` |
| Ruby | `.rb` |
| PHP | `.php` |
| Swift | `.swift` |
| Elixir | `.ex`, `.exs` |
| Lua | `.lua` |
| Shell | `.sh`, `.bash`, `.zsh` |

### By Config File (confirms ecosystem)

| Config File | Ecosystem |
| --- | --- |
| `tsconfig.json` | TypeScript |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `pyproject.toml`, `setup.py` | Python |
| `Gemfile` | Ruby |
| `composer.json` | PHP |
| `Package.swift` | Swift |

### Framework Detection

| Indicator | Framework |
| --- | --- |
| `next.config.*` | Next.js |
| `vite.config.*` | Vite |
| `angular.json` | Angular |
| `svelte.config.*` | SvelteKit |
| `nuxt.config.*` | Nuxt |
| `astro.config.*` | Astro |
| `remix.config.*` | Remix |
| `django` in requirements/imports | Django |
| `flask` in requirements/imports | Flask |
| `fastapi` in requirements/imports | FastAPI |
| `rails` or `Gemfile` with rails | Ruby on Rails |
| `actix`, `axum`, `rocket` in Cargo.toml | Rust web frameworks |
| `gin`, `echo`, `fiber` in go.mod | Go web frameworks |

## License Detection

### From LICENSE/LICENCE File

Read the first few lines and match against known patterns:

| Pattern (first line or key phrase) | License |
| --- | --- |
| "MIT License" | MIT |
| "Apache License, Version 2.0" | Apache-2.0 |
| "GNU GENERAL PUBLIC LICENSE" + "Version 3" | GPL-3.0 |
| "GNU GENERAL PUBLIC LICENSE" + "Version 2" | GPL-2.0 |
| "GNU LESSER GENERAL PUBLIC LICENSE" | LGPL |
| "BSD 2-Clause" | BSD-2-Clause |
| "BSD 3-Clause" | BSD-3-Clause |
| "Mozilla Public License Version 2.0" | MPL-2.0 |
| "ISC License" | ISC |
| "The Unlicense" | Unlicense |
| "Creative Commons" | CC (check variant) |
| "WTFPL" | WTFPL |

### From Package Manifest

Extract the `license` or `license.spdx` field. Use the
[SPDX identifier](https://spdx.org/licenses/) as the canonical name.

## Version Detection

| Source | How to extract |
| --- | --- |
| Package manifest | `version` field |
| Git tags | `git tag --sort=-v:refname \| head -5` |
| Changelog | First version header in CHANGELOG.md |
| Source code | Grep for `VERSION`, `__version__`, `version =` |

## Build System Detection

| Indicator | Build System |
| --- | --- |
| `Makefile` | Make |
| `CMakeLists.txt` | CMake |
| `package.json` scripts | npm/yarn/pnpm scripts |
| `Cargo.toml` | Cargo |
| `go.mod` | Go build |
| `build.gradle` | Gradle |
| `pom.xml` | Maven |
| `Dockerfile` | Docker |
| `docker-compose.yml` | Docker Compose |
| `Justfile` | Just |
| `Taskfile.yml` | Task |
| `Earthfile` | Earthly |
| `meson.build` | Meson |

## Test Framework Detection

| Indicator | Framework |
| --- | --- |
| `jest.config.*`, `"jest"` in package.json | Jest |
| `vitest.config.*` | Vitest |
| `pytest.ini`, `conftest.py`, `pyproject.toml [tool.pytest]` | pytest |
| `tests/` directory with `_test.go` files | Go testing |
| `#[cfg(test)]` in `.rs` files | Rust built-in tests |
| `spec/` directory | RSpec (Ruby) |
| `phpunit.xml` | PHPUnit |
| `.mocharc.*` | Mocha |

## CI/CD Detection

| File/Directory | Platform |
| --- | --- |
| `.github/workflows/` | GitHub Actions |
| `.gitlab-ci.yml` | GitLab CI |
| `Jenkinsfile` | Jenkins |
| `.circleci/` | CircleCI |
| `.travis.yml` | Travis CI |
| `azure-pipelines.yml` | Azure Pipelines |
| `bitbucket-pipelines.yml` | Bitbucket Pipelines |

## Project Type Classification

Use detected metadata to classify the project type, which determines
which README sections to include.

| Type | Indicators |
| --- | --- |
| CLI tool | `bin` field in manifest, argument parsing libraries |
| Library/package | Published to registry, exports API, no `bin` field |
| Web application | Web framework detected, HTML/CSS files, port config |
| API service | REST/GraphQL framework, no frontend, Dockerfile |
| Plugin/extension | Plugin manifest, extends another tool |
| Documentation | Primarily `.md` files, doc generators (MkDocs, Sphinx) |
| Monorepo | Workspace config, multiple package manifests |

## Author Detection

| Source | What to extract |
| --- | --- |
| Package manifest | `author`, `authors`, `contributors` fields |
| `CONTRIBUTORS` file | Listed names |
| Git log | `git log --format='%aN <%aE>' \| sort -u` |
| `CODEOWNERS` | Ownership information |

## Repository URL Detection

```bash
git remote get-url origin
```

Transform SSH URLs to HTTPS for display:
`git@github.com:user/repo.git` becomes `https://github.com/user/repo`

## Release Date Detection

| Metric | Command |
| --- | --- |
| First commit date | `git log --reverse --format='%ai' \| head -1` |
| Latest tag date | `git log -1 --format='%ai' $(git describe --tags --abbrev=0 2>/dev/null)` |
| Latest commit date | `git log -1 --format='%ai'` |
