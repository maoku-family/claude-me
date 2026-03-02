# Architecture

## Overview

claude-me is a personal AI digital worker / AI clone powered by Claude Code. It provides a structured environment for AI-assisted development with custom hooks, skills, agents, and rules.

## Core Principles

1. **Human Plans, AI Executes** - You plan, I execute
2. **Design Before Code** - Think before you code
3. **Repository = Single Source of Truth** - Everything lives in the repo
4. **Test First, Always** - TDD by default
5. **Encode Taste into Tooling** - Codify preferences into skills, agents, hooks
6. **Progressive Disclosure** - Docs link to details, never duplicate

## Directory Structure

### Repository

```text
https://github.com/mao-family/claude-me
~/Repos/claude-me/
├── .claude-plugin/          # Plugin metadata
├── skills/                  # Workflow guides (on-demand loading)
├── agents/                  # Specialized sub-agents
├── hooks/                   # Hook configuration (hooks.json)
├── rules/                   # Coding standards (auto-loaded)
├── scripts/                 # Utility scripts
│   ├── hooks/               # Hook implementation scripts
│   └── lint/                # Lint helper scripts
├── tests/                   # Bats test files
├── memory-bank/             # Project knowledge
├── workspace/
│   ├── repos/{project}/     # Child project repositories
│   └── memory-bank/{project}/ # Child project knowledge
├── CLAUDE.md                # Global instructions
├── mcp.json                 # MCP server config
└── settings.json            # Claude Code settings
```

### Runtime Symlinks

The installation script creates symlinks from `~/.claude/` to the repository:

```text
~/.claude/
├── CLAUDE.md → claude-me
├── settings.json → claude-me
├── rules/ → claude-me
├── workspace/ → claude-me
├── memory-bank/ → claude-me
├── settings.local.json      # Local secrets (not in repo)
└── plugins/                 # Plugin: claude-me@claude-me-marketplace

~/.mcp.json → claude-me/mcp.json
```

## Core Components

### Hooks

Located in `hooks/` (configuration) and `scripts/hooks/` (implementation):

- **hooks.json** - Hook configuration for Claude Code
- **load-project-context.sh** - Loads project-specific CLAUDE.md

### Skills

Located in `skills/`, workflow guides loaded on-demand:

- **writing-claude-md** - Guide for creating CLAUDE.md files
- **writing-docs** - Markdown style and progressive disclosure rules

### Agents

Located in `agents/`, specialized sub-agents for specific tasks or domains.

### Rules

Located in `rules/`, coding standards auto-loaded every session:

- **shell.md** - Shell script style guide
- **lint.md** - Lint tool usage rules

### Scripts

Located in `scripts/`:

- **install.sh** - Creates symlinks and sets up the plugin
- **hooks/** - Hook implementation scripts
- **lint/** - Lint helper scripts (check-lint-disables.sh)

### Tests

Located in `tests/`, Bats test files:

- **hooks.bats** - Tests for hook functionality

## Plugin System

claude-me integrates with Claude Code's plugin system:

- Plugin metadata stored in `.claude-plugin/`
- Plugin registration via `claude plugin marketplace`
- Update with: `claude plugin marketplace update claude-me-marketplace`

## Child Project Convention

For projects under `workspace/repos/`:

| File | Location | Purpose |
|------|----------|---------|
| Project CLAUDE.md | `workspace/memory-bank/{project}/CLAUDE.md` | Project-specific instructions |
| Feature docs | `workspace/memory-bank/{project}/features/{name}/*.md` | Feature branch context |

Child projects are git submodules. Their knowledge files live in `workspace/memory-bank/` to keep repos clean.

## Related Documentation

| Document | Content |
|----------|---------|
| [stack.md](stack.md) | Technology stack overview |
| [lint.md](lint.md) | Detailed linting configuration |
