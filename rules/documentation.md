# Documentation Rules

## Progressive Disclosure

**All documentation MUST follow progressive disclosure:**

1. **Entry points stay concise** - CLAUDE.md, README.md should be overview only
2. **Link to details, don't repeat** - Use links instead of duplicating content
3. **Each file has one depth level** - Overview → Structure → Details → Reference
4. **Simplest viable content** - Remove anything that exists elsewhere

## Document Hierarchy

```text
Level 1: Entry Points (~50-100 lines)
├── CLAUDE.md - Global instructions, links to memory-bank/
├── README.md - Quick start, links to docs

Level 2: Structure (~100 lines)
├── memory-bank/architecture.md - Project structure
├── memory-bank/stack.md - Technology overview

Level 3: Details (~150 lines)
├── memory-bank/lint.md - Detailed configuration

Level 4: Rules (constraints, MUST follow)
├── rules/*.md - Coding standards, style guides
```

## Rules

### Keep It Simple

- **Ask**: "Does this belong at this level?"
- **If content exists elsewhere**: Link, don't copy
- **If content is too detailed**: Move to deeper level

### Every File Must Link

- Link UP to parent document
- Link DOWN to detailed documents
- Use "Related Documentation" section at end

```markdown
## Related Documentation

| Document | Content |
|----------|---------|
| [parent.md](../parent.md) | Parent context |
| [detail.md](detail.md) | Detailed reference |
```

### Content Guidelines by Level

| Level | Max Lines | Content Type | Nature |
|-------|-----------|--------------|--------|
| 1 | ~100 | What + Where (links) | Overview |
| 2 | ~100 | How (structure) | Structure |
| 3 | ~150 | Why (configuration) | Details |
| 4 | ~200 | Constraints | **MUST follow** |

### No Duplication

```markdown
# Bad - duplicates content from lint.md
## ShellCheck
11 optional rules enabled:
- add-default-case
- avoid-negated-conditions
...

# Good - links to detail
## Code Quality

See [lint.md](lint.md) for linting configuration.
```

## Enforcement

When creating or editing documentation:

1. Check current file's level in hierarchy
2. Ensure content matches that level's depth
3. Add links to related documents
4. Remove content that exists elsewhere
