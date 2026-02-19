---
name: readme
description: This skill should be used when the user asks to "create a README", "generate a README", "write a README", "update the README", "improve the README", "document this project", "add project documentation", "this repo needs a README", "/readme", or mentions needing project documentation for a repository. Generates comprehensive, standards-compliant README.md files with auto-detected project metadata and adaptive sections based on project type.
argument-hint: [--update] [--focus <section>]
allowed-tools: Read, Grep, Glob, Bash(git ls-files*), Bash(git log*), Bash(git remote*), Bash(cat LICENSE*), Bash(ls*), Task, Write, Edit, AskUserQuestion
context: fork
model: opus
---

# README

Generate or update a project's README.md following best practices from the
README HOWTO guidelines. Auto-detect project metadata, adapt sections to
project type, and confirm findings before writing.

**Core Principle**: The README is an introduction for someone who has never
heard of the project. Answer "what is this?" immediately.

## Modes

| Mode | Trigger | Behaviour |
| --- | --- | --- |
| **Create** | No README.md exists (default) | Full generation from scratch |
| **Update** | README.md exists or `--update` flag | Analyse gaps, preserve custom content, enhance |
| **Focus** | `--focus <section>` provided | Target a specific section only |

## Process

### Phase 1: Project Discovery

Launch parallel detection to gather project metadata automatically.

**Metadata to detect** (see `references/detection-guide.md` for file patterns):

| Field | Sources |
| --- | --- |
| Project name | package.json, Cargo.toml, pyproject.toml, go.mod, directory name |
| Description | Package manifest "description" field |
| Language + framework | File extensions, config files, imports |
| License | LICENSE file, package manifest "license" field |
| Version | Package manifest, git tags |
| Entry points | main/index files, bin fields, Makefile targets |
| Dependencies | Lock files, manifest dependencies |
| Build system | Makefile, package.json scripts, Cargo, CMake |
| Test framework | Test directories, config files, scripts |
| CI/CD | .github/workflows/, .gitlab-ci.yml, Jenkinsfile |
| Author(s) | git log, package manifest, CONTRIBUTORS |
| Repository URL | git remote -v |
| Release date | First commit date, latest tag date |

Run these in parallel via Task agents:

1. **Metadata Agent** — scan package manifests and config files
2. **Structure Agent** — map directory layout, entry points, build system
3. **Content Agent** — (update mode only) analyse existing README for gaps

### Phase 2: Confirm Findings

Present discovered metadata to the user in a structured summary:

```text
Project: {name}
Language: {language} ({framework if any})
License: {license}
Version: {version}
Description: {detected or "not found — please provide"}
Target users: {inferred or "please specify"}
```

**Use AskUserQuestion** for any missing or ambiguous fields:

- Description (if not found in manifests)
- Target audience
- Project goals
- Whether certain optional sections apply (corporate attribution,
  data transmission, service dependencies)

**Never write without explicit user confirmation of the metadata.**

### Phase 3: Section Selection

Adapt README sections based on project type. Not every project needs
every section from the howto guide.

**Always include (all project types):**

- Project name (hyperlinked) + one-sentence description
- Language, license, version
- Installation / getting started
- Usage examples

**Include when detected or relevant:**

| Section | Include when |
| --- | --- |
| Build instructions | Build system detected (Makefile, CMake, etc.) |
| Prerequisites | External dependencies found |
| Framework description | Language outside the top 10 by popularity |
| Corporate attribution | Corporate indicators found |
| API documentation | Library/API project |
| CLI usage + screenshots | CLI tool detected |
| Configuration | Config files or env vars detected |
| Contributing | CONTRIBUTING.md exists or open-source license |
| Authors | Multiple contributors in git log |
| Community venues | Links found in existing docs |
| Transparency disclosures | Service deps, data transmission, open core |

Refer to `references/readme-howto.md` for the full guidelines on each section.

### Phase 4: Write or Update

#### Create Mode

1. Generate full README following the structural template from
   `references/readme-template.md`
2. Apply the howto guidelines for each section
3. Include real project data — never use placeholder text
4. Hyperlink all proper nouns, languages, licenses, and dependencies
5. Write to `README.md` in project root

#### Update Mode

1. Read existing README.md
2. Identify gaps against the howto checklist
3. Present gap analysis to user:
   - Missing sections
   - Sections that could be improved
   - Outdated information (version, dates)
4. Preserve existing custom content and voice
5. Apply targeted improvements after user approval
6. Use Edit tool for surgical updates (prefer over full rewrite)

#### Focus Mode

1. Read existing README.md
2. Target only the specified section
3. Apply howto guidelines to that section
4. Edit in place

### Phase 5: Validation

After writing, verify the README against the howto quick checklist:

- [ ] First sentence answers "what does this do?" without jargon
- [ ] Project name is hyperlinked
- [ ] Programming language is stated
- [ ] License is named and linked
- [ ] Version and release dates present
- [ ] Target audience identified
- [ ] Build/install commands are copy-paste ready
- [ ] Prerequisites assume a fresh system
- [ ] All acronyms expanded on first use
- [ ] All proper nouns hyperlinked
- [ ] Contribution policy explicit (if applicable)

Report any unchecked items to user with suggested fixes.

## Writing Guidelines

Follow these principles when composing README content:

- **Above the fold matters most** — the first 10-15 lines must fully
  orient a stranger to the project
- **Err toward too many hyperlinks** — link languages, licenses, frameworks,
  companies, standards, file formats on first mention
- **Never assume familiarity** — expand acronyms, explain jargon
- **Copy-paste ready commands** — every command block must work on a
  fresh system
- **No length anxiety** — vertical scrolling is cheap; use clear section
  headings for navigation
- **Real data only** — never leave placeholder text like "TODO" or
  "description here"

## Anti-Patterns to Avoid

- Assuming the reader has heard of the project or its author
- Using unexpanded acronyms or initialisms
- Omitting the programming language
- Omitting the license
- Obfuscating email addresses
- Graphical screenshots for text-only CLI output (use code blocks)

## Additional Resources

### Reference Files

- **`references/readme-howto.md`** — Full README writing guidelines
  (structural template, checklist, anti-patterns, section-by-section guide)
- **`references/detection-guide.md`** — File patterns for auto-detecting
  project metadata across ecosystems
- **`references/readme-template.md`** — Adaptive README template with
  conditional sections

## Output Report

After writing or updating the README:

```text
### README Complete

**Mode**: {Create | Update | Focus}
**File**: README.md
**Sections written**: {count}
**Checklist**: {passed}/{total} items

{Any items that need user attention}
```
