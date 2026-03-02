# Research: affaan-m/everything-claude-code

**Repository:** [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
**Stars:** 53,900+ | **Author:** Affaan Mustafa (Anthropic hackathon winner)
**Version:** 1.7.0 | **License:** MIT
**Research Date:** February 27, 2026

## Overview

Production-ready Claude Code configuration collection with agents, skills, hooks, commands, and rules. Evolved over 10+ months of intensive daily use.

## Key Stats

- 30 contributors
- 6 programming languages (TypeScript, Python, Go, Java, C++, Swift)
- 14 specialized agents
- 56+ workflow skills
- 32+ slash commands
- 992+ tests

## Core Components

### Agents (14 Specialized Subagents)

| Agent | Purpose | Model |
|-------|---------|-------|
| `planner` | Feature implementation planning | Opus |
| `architect` | System design decisions | Opus |
| `tdd-guide` | Test-driven development | Opus |
| `code-reviewer` | Quality and security review | Opus |
| `security-reviewer` | Vulnerability analysis | Opus |
| `build-error-resolver` | Build error resolution | Opus |
| `e2e-runner` | Playwright E2E testing | Opus |

### Rules Structure

```text
rules/
├── common/          # Language-agnostic
│   ├── coding-style.md
│   ├── git-workflow.md
│   ├── testing.md
│   ├── performance.md
│   └── security.md
├── typescript/
├── python/
├── golang/
└── swift/
```

### Key Rules

| Rule | Purpose | Value |
|------|---------|-------|
| **coding-style.md** | Immutability, file organization | Critical |
| **testing.md** | TDD, 80% coverage | Critical |
| **security.md** | Pre-commit security checklist | Critical |
| **agents.md** | Multi-agent orchestration | High |
| **performance.md** | Model selection strategy | High |

### Model Selection Strategy

| Model | Use Case |
|-------|----------|
| **Haiku 4.5** | Lightweight agents, frequent invocation |
| **Sonnet 4.6** | Main development, orchestration |
| **Opus 4.5** | Complex architectural decisions |

## Hooks

| Stage | Hook | Purpose |
|-------|------|---------|
| PreToolUse | Block dev servers | Safety |
| PostToolUse | Auto-format | Code quality |
| SessionStart | Load context | Memory |
| SessionEnd | Persist state | Continuity |

## Key Takeaways for claude-me

### Architectural Patterns

1. **Agent Delegation** - Specialized agents with clear tool permissions
2. **Skill-Based Knowledge** - Encode expertise as reusable skills
3. **Hook-Driven Automation** - Pre/Post tool use for validation
4. **Rules as Guardrails** - Always-follow rules for consistency

### Workflow Patterns

1. **TDD Workflow** - RED → GREEN → REFACTOR, 80% coverage
2. **Planning Workflow** - Requirements → Architecture → Steps
3. **Continuous Learning** - Auto-extract patterns from sessions

### Implementation Recommendations

1. Start with planner and code-reviewer agents
2. Add TDD workflow and coding standards skills
3. Implement session persistence hooks
4. Customize for our stack
