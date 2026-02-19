# README Writing Guidelines

## Above the Fold (First 10-15 Lines, Max 80-100 Columns)

The opening section is the most critical part. It must answer "what is this?"
immediately for someone who has never heard of the project.

### Functional Description

- Lead with a one-sentence statement of what the software does and its purpose.
- Example: "make is a command line tool for running builds based on a
  rules-based Makefile"

### Hyperlink the Project Name

- Link the project name to its official website on first mention.
- Do this even if the README lives on the same repository page — users may
  view it offline, cloned, or in other contexts.

### Programming Language

- State the primary language in the opening description.
- Include tightly-coupled frameworks (e.g. React, Rails).
- Format: "written in C" or "written in ES6 and JSX using React"
- This is one of the most commonly omitted fields.

### License

- Include the license name in the first sentence with a hyperlinked reference.
- Format: "released under the GPL Version 3"
- Do not rely on code forge sidebar badges — the README must stand alone.
- This is critically important and almost universally forgotten.

### Release Timeline

- State the original release date.
- State the current version number and its release date.
- This distinguishes a 0.0.9 from 90 days of work versus a 9.7 from a
  decade-long project.

### Obscure Programming Languages

- For languages outside the top ten, add a 4-6 word parenthetical description.
- Hyperlink the language name.
- Format: "written in [Julia](https://julialang.org) (a high-level dynamic
  programming language for scientific computing, first released in 2012
  under the MIT license)"

### Corporate Attribution

- Name the company if it is a corporate project.
- Hyperlink the company name on first appearance.
- Example: "developed by FooCorp as part of a commercial service offering"

### Project Goals

- State objectives clearly.
- Distinguish between grant-funded research, hobby projects, and commercial
  initiatives.
- Example: "to provide a simple, fast, and reliable way to manage
  dependencies in a large ES6 codebase"

### Target Users

- Explicitly identify the intended audience.
- Examples: "for use by developers of large, complex, multi-language
  projects," "for use by operators of large-scale Kubernetes clusters,"
  "for use by security administrators in regulated financial environments"

### Hyperlinking Policy

- Err toward too many links rather than too few.
- Link in the first section: company names, library names, programming
  languages, license types, distributions, operating systems, dependencies,
  file formats, standards documents.
- Use Wikipedia links if no official site exists.

## Below the Fold

### Build Instructions

- Include exact copy-and-paste commands for building.
- Ideally reduce to a single `make` command.
- Assume build automation is in place.

### Installation Prerequisites

- Provide exact commands for the most common distributions.
- Include commands to install build system dependencies.
- Example: `apt-get install -y libfoo-dev libbar-dev libbaz3-dev cmake`
- Assume a completely fresh VM installation — omit nothing.

### Versioning Scheme

- Specify whether using SemVer, date-based (yyyymmdd.xx), or other schemes.
- Examples: SemVer (major.minor.patch), Ubuntu-style (yy.mm).

### Usage Examples

- Include for small or simple projects.
- Show both example invocation and corresponding output.
- Use text-based code blocks or markdown triple-backticks.

### Text-Based Screenshots

- Include when applicable for CLI tools.
- Use code blocks or pre-formatted text.
- Avoid graphical screenshots for text-only output.

### Project Origin

- Explain why the project was created.
- One or two sentences is acceptable. Full brand narrative is optional.

### Programming Language Features

- Highlight specialty language features or paradigm-specific styles.
- For functional programming libraries: show before/after examples.
- Demonstrate concretely why the project exists.

### Getting Started

- Create a top-level "Getting Started" section for first-time users.
- Include or link to a quickstart guide.
- Link to full documentation.
- Link to community participation information.

## Participation Section

### Authors

- Create a top-level "Authors" section.
- List names/usernames AND email addresses of maintainers.
- Optionally link to personal pages or profiles.
- Make the list reasonably complete to clarify project management scope.

### Contribution Process

- State whether contributions are wanted.
- Specify the bug report method (email, GitHub issues, etc.).
- Address pull request policies explicitly.
- Set expectations on PR acceptance likelihood and review process.
- Do not leave this ambiguous.

### Contribution Requirements

- List all hard requirements completely.
- Link to code style guidelines and linting configurations.
- Specify what CI checks must pass.

### Legal Documentation

- Be extremely clear if a Contributor License Agreement (CLA) is required.
- Distinguish between Developer Certificate of Origin and copyright
  assignment CLAs.
- Transparent example: "Contributions to this project are managed by
  $COMPANYNAME and contributors must sign a Contributor License Agreement
  (CLA) and copyright assignment to be included so that $COMPANYNAME may
  dual-license this software"

### Community Venues

- Use the README as authoritative documentation of all collaboration venues.
- List and link every community gathering place: bug trackers, wikis, social
  media, subreddits, forums, IRC channels, Slack groups, Discord servers,
  Matrix rooms, ActivityPub, mailing lists.
- Sort the list to steer participants toward preferred or most-active venues.

## Ideology and Transparency Section

### Code of Conduct

- Make community behavioural expectations clear.
- Link to the Code of Conduct if one exists.
- Name standard COCs if applicable (e.g. Contributor Covenant).
- Explicitly state if no COC exists.

### Open Core Transparency

- Clarify if the project exists primarily as a for-profit company tool.
- Disclose if features like SSO, audit logging, or other functionality are
  gated behind a dual-licensing or paid tier.
- Be clear about the business model so contributors have full context.

### Free/Nonfree Software Mix

- Clarify if this project is one free software component in a larger
  nonfree system.
- Specify if nonfree components exist alongside free software.

### Centralized Service Dependency

- State clearly if the software primarily interfaces with a single
  centralized service.
- Link to that service.
- Link to the associated EULA or Terms of Service.

### User Data Transmission

- State clearly if the software transmits user activity data off-device.
- Link to the associated privacy policy.

## Anti-Patterns

### Assumptions

- Do not assume the audience has heard of the project, author, or
  programming language.
- Do not assume readers understand industry or specialty jargon.
- The README is an introduction for a general technical audience.

### Acronyms

- Never use acronyms, initialisms, or abbreviations without expanding
  them on first use.
- Prefer expanded versions exclusively when not onerous.

### Length Anxiety

- Do not worry about the README becoming too long — vertical scrolling is
  cheap.
- Use good section headings for navigation.
- Factor sections out to separate files later if needed, replacing inline
  content with links.

### Email Obfuscation

- Do not obfuscate email addresses.
- Write full addresses and linkify via `mailto:` URLs.
- Obfuscation is ineffective — crawlers use regex regardless.

### Issue Management

- Do not leave issues open if bug reports are unwanted.
- Do not invite bug reports without willingness to engage.
- Do not auto-close issues for inactivity — this dismisses contributors.

## Quick Checklist

Before finalizing a README, verify:

- [ ] First sentence answers "what does this do?" without jargon
- [ ] Project name is hyperlinked to official site
- [ ] Programming language is stated explicitly
- [ ] License is named and linked
- [ ] Version number and release dates are present
- [ ] Target audience is identified
- [ ] Build commands are copy-paste ready
- [ ] Prerequisites assume a fresh system
- [ ] All acronyms are expanded on first use
- [ ] All proper nouns (companies, libraries, languages) are hyperlinked
- [ ] Contribution policy is explicit (wanted or not, process, legal)
- [ ] Community venues are listed and linked
- [ ] Data transmission / privacy implications are disclosed
