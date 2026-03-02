# Research Document Rules

Rules for writing research notes in `memory-bank/research/`.

## Code Blocks

**ALWAYS specify language for code blocks:**

```bash
# Good
echo "hello"
```

```text
# Good for plain text/output
Some output here
```

NOT:

<!-- markdownlint-disable MD040 -->
```
# Bad - no language specified
echo "hello"
```
<!-- markdownlint-enable MD040 -->

## Headings

**Use proper headings, NOT bold text as headings:**

```markdown
# Good
### Section Name

Content here

# Bad
**Section Name**

Content here
```

**Maintain heading hierarchy (no skipping levels):**

```markdown
# Good
## Section
### Subsection
#### Detail

# Bad
## Section
#### Detail (skipped h3)
```

## Structure

- Use `##` for main sections
- Use `###` for subsections
- Use `####` sparingly for deep nesting
- Prefer flat structure over deep nesting

## Quick Reference

| Element | Format |
|---------|--------|
| Code block | ` ```bash ` or ` ```text ` |
| Section heading | `### Name` (NOT `**Name**`) |
| Subsection | One level deeper than parent |
