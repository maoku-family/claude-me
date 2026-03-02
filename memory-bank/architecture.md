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
├── skills/                  # Workflow guides
├── agents/                  # Specialized sub-agents
├── hooks/                   # Automation hooks
├── rules/                   # Coding standards
├── scripts/                 # Installation and utility scripts
├── memory-bank/             # claude-me project knowledge
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

Located in `hooks/`, automation scripts that integrate with Claude Code:

- **load-project-context.sh** - Automatically loads project-specific CLAUDE.md when working in child projects

### Skills

Located in `skills/`, workflow guides that define reusable patterns and procedures for Claude Code to follow.

### Agents

Located in `agents/`, specialized sub-agents for specific tasks or domains.

### Rules

Located in `rules/`, coding standards and style guides:

- **markdown.md** - Markdown formatting rules

### Scripts

Located in `scripts/`, utility and installation scripts:

- **install.sh** - Creates symlinks and sets up the plugin

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
