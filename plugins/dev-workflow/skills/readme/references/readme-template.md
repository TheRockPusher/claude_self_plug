# Adaptive README Template

Use this template when generating a README from scratch. Include or skip
conditional sections based on project type and detected metadata.

Sections marked `[CONDITIONAL]` should only be included when relevant.
Sections marked `[ALWAYS]` are required for all project types.

---

## Template

````markdown
# [{Project Name}]({project-url})

{One-sentence description of what the software does, its purpose, and who
it's for.} Written in [{language}]({language-url}){framework clause},
released under the [{license}]({license-url}).
{Current version and date clause.}

<!-- CONDITIONAL: Corporate attribution -->
Developed by [{company}]({company-url}) {context}.

<!-- CONDITIONAL: Obscure language (outside top 10) -->
<!-- Add parenthetical: "(a {4-6 word description}, first released in
{year} under the {license})" after language name -->

## Overview

{2-4 sentence expansion of what the project does. Include:
- Primary purpose and goals
- Key capabilities
- Target audience}

<!-- CONDITIONAL: CLI tool — include a text-based screenshot -->

```text
$ {command} {typical-args}
{sample output}
```

## Getting Started

### Prerequisites

{List all system-level dependencies needed on a fresh installation.
Provide exact install commands for common platforms.}

**Debian/Ubuntu:**

```bash
{apt-get install commands}
```

**macOS:**

```bash
{brew install commands}
```

<!-- CONDITIONAL: Other platforms as relevant -->

### Installation

{Exact copy-paste commands to install. Show the most common method first.}

```bash
{install command}
```

<!-- CONDITIONAL: Multiple install methods — show each -->

<!-- CONDITIONAL: Build from source needed -->

### Building from Source

```bash
git clone {repo-url}
cd {project-name}
{build commands}
```

## Usage

{Show the most common use case with actual command and output.}

```bash
{command example}
```

{Output:}

```text
{example output}
```

<!-- CONDITIONAL: Additional usage examples for key features -->

### {Feature/Use Case Name}

```bash
{example}
```

<!-- CONDITIONAL: Library/API — show code examples -->

```{language}
{import and usage example}
```

<!-- CONDITIONAL: Configuration section -->

## Configuration

{Describe configuration files, environment variables, or CLI flags.}

| Option | Default | Description |
| --- | --- | --- |
| {option} | {default} | {description} |

<!-- CONDITIONAL: API documentation for libraries -->

## API

{Key API surface. Link to full docs if extensive.}

### `{function/method signature}`

{Description and parameters.}

## Versioning

This project uses [{versioning scheme}]({scheme-url}).
{Brief explanation if non-standard.}

<!-- CONDITIONAL: Project origin story -->

## Background

{1-2 sentences on why the project was created and what problem it solves.}

## Contributing

<!-- CONDITIONAL: Contributions welcome -->
Contributions are welcome. {Process description.}

- **Bug reports**: {method — GitHub Issues, email, etc.}
- **Pull requests**: {policy — review process, requirements}
- **Code style**: {link to style guide or linter config}

<!-- CONDITIONAL: CI requirements -->
All pull requests must pass: {list CI checks}.

<!-- CONDITIONAL: CLA/DCO required -->

### Legal

{CLA or DCO requirement with full transparency.}

<!-- CONDITIONAL: Contributions not wanted -->
This project does not currently accept contributions.
Bug reports may be filed at {method}.

## Authors

{List of maintainers with contact information.}

- **{Name}** — [{email}](mailto:{email}) {optional link to profile}

<!-- CONDITIONAL: Community venues exist -->

## Community

{Ordered list of collaboration venues, preferred first.}

- [{venue name}]({url}) — {brief description}

<!-- CONDITIONAL: Code of Conduct exists -->

## Code of Conduct

This project follows the [{CoC name}]({coc-url}).
{Or: "This project does not have a formal code of conduct."}

<!-- CONDITIONAL: Transparency disclosures needed -->

## Transparency

<!-- CONDITIONAL: Open core / dual licensing -->
{Business model disclosure.}

<!-- CONDITIONAL: Service dependency -->
This software interfaces with [{service}]({service-url}).
See the [Terms of Service]({tos-url}).

<!-- CONDITIONAL: Data transmission -->
This software transmits {what data} to {where}.
See the [Privacy Policy]({privacy-url}).

## License

[{License full name}]({license-url}) — see [LICENSE](./LICENSE) for details.
````

---

## Section Inclusion Matrix

Quick reference for which sections to include by project type.

| Section | CLI | Library | Web App | API | Plugin | Docs |
| --- | --- | --- | --- | --- | --- | --- |
| Overview | Yes | Yes | Yes | Yes | Yes | Yes |
| CLI screenshot | Yes | - | - | - | Maybe | - |
| Prerequisites | Yes | Yes | Yes | Yes | Yes | Yes |
| Installation | Yes | Yes | Yes | Yes | Yes | Yes |
| Build from source | Maybe | Maybe | Yes | Yes | Maybe | - |
| Usage examples | Yes | Yes | - | Yes | Yes | - |
| Code examples | - | Yes | - | Yes | Maybe | - |
| Configuration | Maybe | Maybe | Yes | Yes | Maybe | Maybe |
| API docs | - | Yes | - | Yes | Maybe | - |
| Versioning | Yes | Yes | Yes | Yes | Yes | - |
| Background | Maybe | Maybe | Maybe | Maybe | Maybe | Maybe |
| Contributing | Yes | Yes | Yes | Yes | Yes | Yes |
| Authors | Yes | Yes | Yes | Yes | Yes | Yes |
| Community | Maybe | Maybe | Maybe | Maybe | Maybe | Maybe |
| CoC | Maybe | Maybe | Maybe | Maybe | Maybe | Maybe |
| Transparency | Maybe | Maybe | Maybe | Maybe | Maybe | - |
| License | Yes | Yes | Yes | Yes | Yes | Yes |

## First Paragraph Formula

The opening paragraph must pack maximum information density. Follow this
formula:

```text
[{Name}]({url}) is a {what-it-does} written in [{language}]({lang-url})
{using [{framework}]({fw-url})}, released under the
[{license}]({license-url}). {Version info.}
```

**Examples:**

> [ripgrep](https://github.com/BurntSushi/ripgrep) is a line-oriented
> search tool that recursively searches directories for a regex pattern,
> written in [Rust](https://www.rust-lang.org/), released under the
> [MIT License](https://opensource.org/licenses/MIT). Current version:
> 14.1.1 (January 2025), first released in September 2016.

<!-- separate blockquotes -->

> [FastAPI](https://fastapi.tiangolo.com/) is a modern web framework for
> building APIs, written in [Python](https://python.org) using
> [Starlette](https://www.starlette.io/) and
> [Pydantic](https://docs.pydantic.dev/), released under the
> [MIT License](https://opensource.org/licenses/MIT). Current version:
> 0.115.0 (December 2024), first released in December 2018.

## Hyperlink Reference

Common URLs for first-paragraph hyperlinks:

| Entity | URL Pattern |
| --- | --- |
| MIT License | `https://opensource.org/licenses/MIT` |
| Apache 2.0 | `https://www.apache.org/licenses/LICENSE-2.0` |
| GPL 3.0 | `https://www.gnu.org/licenses/gpl-3.0.html` |
| BSD 3-Clause | `https://opensource.org/licenses/BSD-3-Clause` |
| MPL 2.0 | `https://www.mozilla.org/en-US/MPL/2.0/` |
| Python | `https://python.org` |
| Rust | `https://www.rust-lang.org/` |
| Go | `https://go.dev/` |
| TypeScript | `https://www.typescriptlang.org/` |
| JavaScript | `https://developer.mozilla.org/en-US/docs/Web/JavaScript` |
| Java | `https://www.java.com/` |
| C# | `https://learn.microsoft.com/en-us/dotnet/csharp/` |
| Ruby | `https://www.ruby-lang.org/` |
| SemVer | `https://semver.org/` |
