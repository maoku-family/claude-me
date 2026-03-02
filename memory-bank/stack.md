# Technology Stack

## Core

| Category | Tool | Purpose |
|----------|------|---------|
| Language | Bash | Scripts, hooks, skills |
| Testing | Bats-core | Shell test framework |
| Runtime | Bun | npm scripts runner |

## Code Quality

| Tool | Purpose |
|------|---------|
| pre-commit | Git hook automation |
| ShellCheck | Shell static analysis |
| shfmt | Shell formatting |
| markdownlint | Markdown linting |

See [lint.md](lint.md) for detailed configuration.

## Quick Commands

```bash
bun run lint          # All checks
bun run test          # Run tests
```

## Configuration Files

| File | Purpose |
|------|---------|
| `.shellcheckrc` | ShellCheck rules |
| `.editorconfig` | Editor + shfmt settings |
| `.markdownlint.json` | Markdown rules |
| `.pre-commit-config.yaml` | Pre-commit hooks |

See [architecture.md](architecture.md) for project structure.
