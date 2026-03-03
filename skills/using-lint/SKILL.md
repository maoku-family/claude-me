---
name: using-lint
description: Use when adding eslint-disable, shellcheck disable, or similar lint suppression comments. Also use when considering --no-verify, modifying .eslintrc/.shellcheckrc, or adding global lint rule exceptions.
---

# Using Lint Tools

## Never Disable Without Justification

**Every disable must have:**

1. A clear reason in a comment
2. The narrowest possible scope

```bash
# Bad
# shellcheck disable=SC2034

# Good
# shellcheck disable=SC2034  # Variable used by sourced script
readonly MY_VAR="value"
```

```markdown
<!-- Bad -->
<!-- markdownlint-disable MD040 -->

<!-- Good -->
<!-- markdownlint-disable MD040 -- Example of bad code -->
```

## Pre-approved Disables

| Tool | Rule | Reason |
|------|------|--------|
| ShellCheck | SC1091 | Cannot follow dynamic source paths |
| ShellCheck | SC1003 | False positive in case patterns |
| markdownlint | MD013 | Line length not suitable for Markdown |
| markdownlint | MD043/44 | Heading templates too strict |
| markdownlint | MD060 | Table alignment too strict |

## Never Skip Pre-commit

```bash
# NEVER do this
git commit --no-verify

# If a check fails, FIX the issue
```

## Prefer Auto-fix Over Disable

```bash
# Bad
# shfmt: ignore

# Good
shfmt -w script.sh
bun run lint:markdown  # auto-fix
```

## Adding New Global Disables

1. Document the reason in `.shellcheckrc` or `.markdownlint.json`
2. Update memory-bank/lint.md
