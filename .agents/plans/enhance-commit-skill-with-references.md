# Feature: Enhance Commit Skill with Reference Documentation and Template Files

> **IMPORTANT**: This plan uses parallel Task agents for documentation
> research and skill-development agents to create reference materials following
> Claude Code plugin best practices.

## Overview

**Description**: Enhance the dev-workflow commit skill by separating concerns into
modular reference documentation and templates. The skill will be restructured to
follow progressive disclosure patterns with dedicated files for conventional
commits reference and commit message templates.

**Problem**: The current commit skill embeds all reference information (commit
types, emojis, format examples) directly in SKILL.md. This violates progressive
disclosure principles and makes the skill harder to maintain and extend.

**Solution**: Launch specialized Task agents to gather documentation from
conventional commits and Claude Code best practices, then use skill-development
agents to create structured reference files. The result will be a lean SKILL.md
that references detailed documentation stored in `references/` subdirectory.

## Metadata

| Field            | Value                                         |
|------------------|-----------------------------------------------|
| Type             | Enhancement                                   |
| Complexity       | Medium                                        |
| Systems Affected | dev-workflow plugin, commit skill             |
| Dependencies     | Task tool, skill-development agents, WebFetch |

---

## CONTEXT REFERENCES

### Mandatory Reading (READ BEFORE IMPLEMENTING)

- `plugins/dev-workflow/skills/commit/SKILL.md:1-151` - Current commit
  skill implementation
- `plugins/dev-workflow/skills/primer/SKILL.md:1-85` - Example skill using
  references pattern
- `plugins/dev-workflow/skills/primer/references/output-templates.md:1-174` -
  Reference file example
- `plugins/dev-workflow/skills/plan/references/plan-template.md:1-247` -
  Another reference file example
- `/home/calhau/.claude/plugins/marketplaces/claude-plugins-official/plugins/plugin-dev/skills/skill-development/SKILL.md:1-638`
  \- Skill development best practices

### New Files to Create

- `plugins/dev-workflow/skills/commit/references/conventional-commits.md` -
  Conventional commits reference documentation
- `plugins/dev-workflow/skills/commit/references/commit-templates.md` -
  Commit message format templates and examples

### Files to Update

- `plugins/dev-workflow/skills/commit/SKILL.md` - Refactor to reference new
  files, remove embedded reference content

### External Documentation References

- [Conventional Commits](https://www.conventionalcommits.org/) - Official specification
- Claude Code Documentation - Skill development best practices (via Task agent)

### Patterns to Follow

**Skill Structure (from primer skill):**

```markdown
## Document Templates

Refer to `references/output-templates.md` for the structure of each output document.
```

**Reference File Header:**

```markdown
# {Title}

> Reference documentation for {purpose}
```

**Progressive Disclosure:**

- SKILL.md: Core workflow and process (1,500-2,000 words)
- references/: Detailed reference information, examples, extended documentation

### Boundaries

**ALWAYS:**

- Use imperative/infinitive form in SKILL.md (not second person)
- Keep SKILL.md under 2,000 words by moving details to references/
- Reference supporting files clearly
- Include specific file paths when referencing bundled resources
- Run `markdownlint-cli2 --fix` on all markdown files (PostToolUse hook)

**ASK FIRST:**

- If the structure deviates significantly from the plan
- If additional reference files would be beneficial

**NEVER:**

- Use second person ("you should") in skill documentation
- Duplicate content between SKILL.md and reference files
- Skip validation commands
- Modify files outside the commit skill directory without approval

---

## IMPLEMENTATION PLAN

### Phase 1: Documentation Research

Launch parallel Task agents to gather source material for reference files.

**Tasks:**

- Launch Explore agent to fetch conventional commits documentation
- Launch Explore agent to fetch Claude Code skill development best practices
- Collect documentation on commit message formats, types, scopes, and examples

### Phase 2: Reference File Generation

Use skill-development agents to create structured reference files.

**Tasks:**

- Launch skill-development agent to create `references/conventional-commits.md`
  - Input: Conventional commits documentation from Phase 1
  - Output: Comprehensive reference covering types, scopes, format, examples
  - Include: Breaking changes, multi-line messages, footer conventions

- Launch skill-development agent to create `references/commit-templates.md`
  - Input: Current commit type mappings from SKILL.md:90-105
  - Output: Template file with format examples for each commit type
  - Include: Simple templates, scoped templates, multi-line templates

### Phase 3: SKILL.md Refactoring

Update SKILL.md to follow progressive disclosure pattern.

**Tasks:**

- Remove embedded reference content (commit types table, examples)
- Add "Reference Documentation" section pointing to new files
- Keep core workflow and process instructions
- Ensure SKILL.md stays under 2,000 words
- Maintain all frontmatter (name, description, argument-hint, allowed-tools, etc.)

### Phase 4: Validation & Quality

Ensure all changes follow project conventions and pass validation.

**Tasks:**

- Verify markdown lint passes for all files
- Check that references are properly linked
- Validate skill structure matches plugin-dev best practices
- Test that SKILL.md is lean and references are comprehensive

---

## STEP-BY-STEP TASKS

> Execute every task in order, top to bottom. Each task is atomic and testable.

### Task 1: CREATE references directory structure

- **IMPLEMENT**: Create `plugins/dev-workflow/skills/commit/references/` directory
- **VALIDATE**: `ls -la plugins/dev-workflow/skills/commit/references/`

### Task 2: RESEARCH conventional commits documentation

- **IMPLEMENT**: Launch Task agent (subagent_type=Explore) to fetch and
  analyze <https://www.conventionalcommits.org/>
- **EXTRACT**: Commit types, structure, format specification, examples, footer
  conventions
- **STORE**: Save findings for use in Task 4
- **VALIDATE**: Agent returns comprehensive documentation summary

### Task 3: RESEARCH Claude Code skill best practices

- **IMPLEMENT**: Launch Task agent to review skill-development documentation
- **EXTRACT**: Progressive disclosure patterns, reference file structure,
  writing style requirements
- **STORE**: Save patterns for Tasks 4-5
- **VALIDATE**: Agent identifies key patterns for reference file creation

### Task 4: CREATE references/conventional-commits.md

- **IMPLEMENT**: Launch Task agent (subagent_type=general-purpose) with
  skill-development context
- **INPUT**: Conventional commits documentation from Task 2
- **OUTPUT**: Create `plugins/dev-workflow/skills/commit/references/conventional-commits.md`
- **CONTENT**:
  - Overview of conventional commits
  - Commit message structure (type, scope, description, body, footer)
  - Standard commit types with descriptions
  - Breaking change indicators
  - Examples of simple and complex commit messages
  - Footer conventions (BREAKING CHANGE, Refs, etc.)
- **PATTERN**: Mirror structure from `plugins/dev-workflow/skills/primer/references/output-templates.md`
- **VALIDATE**: `ls -la plugins/dev-workflow/skills/commit/references/conventional-commits.md`

### Task 5: CREATE references/commit-templates.md

- **IMPLEMENT**: Launch Task agent (subagent_type=general-purpose) with
  skill-development context
- **INPUT**: Current commit type/emoji mappings from SKILL.md:90-105
- **OUTPUT**: Create `plugins/dev-workflow/skills/commit/references/commit-templates.md`
- **CONTENT**:
  - Template header explaining format patterns
  - Simple format: `type: emoji description`
  - Scoped format: `type(scope): emoji description`
  - Multi-line format with body
  - Table of commit types with emojis and use cases
  - Real examples for each commit type
- **PATTERN**: Use imperative form, include copy-paste ready templates
- **VALIDATE**: `ls -la plugins/dev-workflow/skills/commit/references/commit-templates.md`

### Task 6: UPDATE SKILL.md - Remove embedded reference content

- **IMPLEMENT**: Edit `plugins/dev-workflow/skills/commit/SKILL.md`
- **REMOVE**: Lines 90-105 (Commit Type Reference table)
- **REMOVE**: Inline examples that duplicate template content
- **PRESERVE**: All frontmatter, core workflow (Phases 1-6), constraints section
- **VALIDATE**: `wc -w plugins/dev-workflow/skills/commit/SKILL.md` (should
  be <2000 words)

### Task 7: UPDATE SKILL.md - Add reference documentation section

- **IMPLEMENT**: Add new section to SKILL.md after Phase 6 and before Constraints
- **ADD**: Section titled "Reference Documentation"
- **CONTENT**:

```markdown
## Reference Documentation

For detailed information on commit formats and conventions:

- **`references/conventional-commits.md`** - Conventional commits
  specification, structure, and examples
- **`references/commit-templates.md`** - Commit message templates for all
  types with emoji indicators
```

- **VALIDATE**: Section appears in correct location with proper markdown formatting

### Task 8: UPDATE SKILL.md - Simplify commit message format section

- **IMPLEMENT**: Streamline Phase 5 (Commit Creation) section
- **REPLACE**: Detailed format examples with reference to templates file
- **KEEP**: Core rules (72 char limit, imperative mood, no signatures)
- **ADD**: Pointer to `references/commit-templates.md` for format examples
- **VALIDATE**: Phase 5 is concise and references templates

### Task 9: VALIDATE markdown linting

- **IMPLEMENT**: Run markdown linter on all modified files
- **COMMAND**:
  `npx markdownlint-cli2 --fix plugins/dev-workflow/skills/commit/SKILL.md plugins/dev-workflow/skills/commit/references/*.md`
- **FIX**: Any remaining lint errors reported by PostToolUse hook
- **VALIDATE**: All markdown files pass linting with zero errors

### Task 10: VERIFY skill structure

- **IMPLEMENT**: Check skill directory structure matches best practices
- **CHECK**: SKILL.md has valid frontmatter (name, description)
- **CHECK**: references/ directory exists with both files
- **CHECK**: SKILL.md properly references both reference files
- **CHECK**: Total word count of SKILL.md is under 2,000 words
- **VALIDATE**:
  `find plugins/dev-workflow/skills/commit -type f -name "*.md" | xargs ls -lh`

### Task 11: FINAL REVIEW

- **IMPLEMENT**: Read all three files (SKILL.md + 2 references) to verify coherence
- **CHECK**: No duplicated content between files
- **CHECK**: All references from SKILL.md point to correct files
- **CHECK**: Writing style is consistent (imperative form)
- **CHECK**: Progressive disclosure achieved (core in SKILL.md, details in references/)
- **VALIDATE**: Manual review confirms quality

---

## TESTING STRATEGY

### Unit Tests

Not applicable - this is documentation enhancement, not code.

### Integration Tests

**Skill Loading Test:**

- Install plugin locally: `claude --plugin-dir ./plugins/dev-workflow`
- Verify skill appears in skill menu
- Trigger skill with `/commit` command
- Confirm skill loads without errors

**Reference Access Test:**

- During skill execution, verify Claude can read reference files when needed
- Check that references/ files are discovered and loaded

### Edge Cases

- **Missing reference files**: Ensure SKILL.md gracefully handles missing
  references (though they should always exist)
- **Markdown lint failures**: Verify PostToolUse hook catches and reports issues
- **Oversized SKILL.md**: Confirm final word count stays under 2,000 words

---

## VALIDATION COMMANDS

> Execute every command to ensure zero regressions.

### Level 1: Syntax & Style

```bash
# Markdown linting (enforced by PostToolUse hook)
npx markdownlint-cli2 plugins/dev-workflow/skills/commit/SKILL.md plugins/dev-workflow/skills/commit/references/*.md

# Word count check (SKILL.md should be <2000 words)
wc -w plugins/dev-workflow/skills/commit/SKILL.md
```

### Level 2: Type Check

Not applicable - no typed code in this feature.

### Level 3: Unit Tests

Not applicable - documentation enhancement only.

### Level 4: Integration Tests

```bash
# Verify skill structure
find plugins/dev-workflow/skills/commit -name "*.md" -o -name "references" | sort

# Test plugin loading (requires Claude Code CLI)
claude --plugin-dir ./plugins/dev-workflow --help | grep commit
```

### Level 5: Manual Validation

**File Structure:**

- [ ] `plugins/dev-workflow/skills/commit/references/` directory exists
- [ ] `references/conventional-commits.md` exists and is comprehensive
- [ ] `references/commit-templates.md` exists with all commit type templates
- [ ] SKILL.md is under 2,000 words
- [ ] SKILL.md properly references both reference files

**Content Quality:**

- [ ] No duplicated content between SKILL.md and reference files
- [ ] All commit types from original SKILL.md appear in templates
- [ ] Writing style is imperative form (not second person)
- [ ] Reference files are comprehensive and well-organized
- [ ] Markdown lint passes with zero errors

**Functional:**

- [ ] Skill can be loaded via Claude Code CLI
- [ ] References can be accessed during skill execution
- [ ] Core workflow in SKILL.md is clear and actionable

---

## ACCEPTANCE CRITERIA

- [ ] `references/` directory created in commit skill folder
- [ ] `references/conventional-commits.md` contains comprehensive conventional
  commits documentation
- [ ] `references/commit-templates.md` contains all commit type templates with emojis
- [ ] SKILL.md refactored to reference new files instead of embedding content
- [ ] SKILL.md word count is under 2,000 words
- [ ] All markdown files pass `markdownlint-cli2` with zero errors
- [ ] No duplicated content between SKILL.md and reference files
- [ ] Writing style is consistent (imperative/infinitive form)
- [ ] Progressive disclosure achieved (lean SKILL.md, detailed references/)
- [ ] Skill structure follows plugin-dev best practices

---

## EXECUTION TODOS

> Pre-built todo structure for implementation agent:

1. Create references/ directory structure
2. Launch Task agent to research conventional commits documentation
3. Launch Task agent to research Claude Code skill best practices
4. Launch skill-development agent to create references/conventional-commits.md
5. Launch skill-development agent to create references/commit-templates.md
6. Update SKILL.md to remove embedded reference content
7. Update SKILL.md to add reference documentation section
8. Update SKILL.md to simplify and reference templates
9. Run markdown linting validation
10. Verify skill structure and word count
11. Final review for coherence and quality

---

## NOTES

### Design Decisions

**Why separate conventional-commits.md and commit-templates.md?**

- `conventional-commits.md`: Educational reference explaining the specification
- `commit-templates.md`: Practical templates for immediate use with
  project-specific emojis
- Separation allows Claude to load only what's needed (templates for quick
  commits, full spec for complex scenarios)

**Why use Task agents for file creation?**

- Follows the user's explicit request
- Demonstrates proper use of parallel agents for research and generation
- Task agents can fetch and synthesize external documentation effectively
- Skill-development agents ensure output follows Claude Code best practices

**Why move commit types to reference files?**

- Original SKILL.md: 151 lines, includes reference table (15 lines)
- Progressive disclosure: Core workflow stays in SKILL.md, reference data
  moves to dedicated file
- Easier to maintain and extend commit types without bloating SKILL.md
- Follows pattern from primer skill (references output-templates.md)

### Trade-offs

**Parallel vs Sequential Agent Execution:**

- **Chosen**: Parallel execution for research agents (Tasks 2-3) and creation
  agents (Tasks 4-5)
- **Benefit**: Faster execution, agents work independently
- **Risk**: Must coordinate agent outputs and ensure consistency
- **Mitigation**: Clear task boundaries, review in Task 11

**Single vs Multiple Reference Files:**

- **Chosen**: Two files (conventional-commits.md, commit-templates.md)
- **Alternative**: Single references/guide.md with all content
- **Benefit**: Separation of concerns (spec vs templates), targeted loading
- **Trade-off**: Slightly more complex file structure

### Risks

#### Risk 1: Agent Coordination

- Multiple Task agents working in parallel may produce inconsistent
  documentation
- **Mitigation**: Task 11 includes final review to ensure coherence

#### Risk 2: SKILL.md Too Lean

- Removing too much content might make SKILL.md less useful standalone
- **Mitigation**: Keep core workflow and process in SKILL.md, only move
  reference data

#### Risk 3: Markdown Linting Failures

- PostToolUse hook may catch issues during implementation
- **Mitigation**: Task 9 explicitly runs linting, Task 11 confirms clean
  state

---

## Confidence Score: 9/10

**Rationale:**

- Strong understanding of skill structure from plugin-dev documentation
- Clear examples from primer and plan skills showing references/ pattern
- All necessary patterns and templates identified
- External documentation URLs known (conventionalcommits.org)
- Validation commands are straightforward (markdown lint, word count)
- Only minor unknown: exact output format from Task agents, but Task 11
  review mitigates this

**-1 point:** First time using this specific combination of research +
skill-development agents, slight uncertainty about coordination and output
quality. However, the review step and clear task boundaries make this
low-risk.
