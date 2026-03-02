# Insight: Vibe-Coding Workflow

**Date:** February 27, 2026

**Sources:**

- [Research: EnzeD/vibe-coding](../research/vibe-coding.md)
- [Research: obra/superpowers](../research/superpowers.md)
- [Research: affaan-m/everything-claude-code](../research/everything-claude-code.md)
- [Research: everything-claude-code Rules Collection](../research/everything-claude-code.md)
- [Community Resources](../research/community-resources.md)
- [OpenAI Harness Engineering](../research/openai-harness-engineering.md)

---

## Core Principles

| # | Principle |
|---|-----------|
| 1 | **Human Plans, AI Executes** |
| 2 | **Design Before Code** |
| 3 | **Repository = Single Source of Truth** |
| 4 | **Test First, Always** |
| 5 | **Encode Taste into Tooling** |

---

## Workflow Architecture

```text
┌─────────────────────────────────────────────────────────────────┐
│                         WORKFLOW FLOW                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐                   │
│  │INITIALIZE│───▶│BRAINSTORM│───▶│   PLAN   │                   │
│  │          │    │          │    │          │                   │
│  │ Hook:    │    │ Agent:   │    │ Agent:   │                   │
│  │ Session  │    │ architect│    │ planner  │                   │
│  │ Start    │    │          │    │          │                   │
│  └──────────┘    └──────────┘    └──────────┘                   │
│                        │               │                         │
│                        ▼               ▼                         │
│                  <HARD-GATE>     2-5 min tasks                   │
│                                        │                         │
│                                        ▼                         │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐                   │
│  │  LEARN   │◀───│  COMMIT  │◀───│  REVIEW  │◀──┐               │
│  │          │    │          │    │          │   │               │
│  │ Hook:    │    │ Hook:    │    │ Agents:  │   │               │
│  │ Session  │    │ PreTool  │    │ code-    │   │               │
│  │ End      │    │ Use      │    │ reviewer │   │               │
│  └──────────┘    └──────────┘    └──────────┘   │               │
│                                        ▲        │               │
│                                        │        │               │
│                                  ┌──────────┐   │               │
│                                  │ EXECUTE  │───┘               │
│                                  │          │                   │
│                                  │ Subagent │                   │
│                                  │ + TDD    │                   │
│                                  └──────────┘                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Component Adoption Recommendations

### Skills (from superpowers + everything-claude-code)

| Priority | Skill | Purpose |
|----------|-------|---------|
| 🔴 HIGH | `brainstorming` | Enforce design-first approach |
| 🔴 HIGH | `test-driven-development` | TDD workflow enforcement |
| 🔴 HIGH | `writing-plans` | Generate 2-5 minute granular tasks |
| 🟡 MED | `subagent-driven-development` | Independent subagent per task |
| 🟡 MED | `systematic-debugging` | Root cause > random fixes |
| 🟢 LOW | `using-git-worktrees` | Feature isolation |

### Rules (from everything-claude-code)

| Priority | Rule | Purpose |
|----------|------|---------|
| 🔴 HIGH | `agents.md` | Multi-agent orchestration |
| 🔴 HIGH | `coding-style.md` | Immutability, file organization |
| 🔴 HIGH | `testing.md` | 80% coverage, TDD enforcement |
| 🔴 HIGH | `security.md` | Pre-commit security checklist |
| 🟡 MED | `development-workflow.md` | Plan → TDD → Review → Commit |

### Hooks

| Stage | Hook | Purpose |
|-------|------|---------|
| SessionStart | Load memory-bank | Restore context |
| SessionEnd | Save progress | Persist state |
| PreToolUse | Block dangerous ops | Safety guard |
| PostToolUse | Auto-format | Code quality |

### Agents (from everything-claude-code)

| Agent | Purpose | Model |
|-------|---------|-------|
| `planner` | Plan implementation steps | Opus |
| `architect` | System design decisions | Opus |
| `tdd-guide` | TDD workflow guidance | Opus |
| `code-reviewer` | Code quality review | Opus |
| `security-reviewer` | Security vulnerability analysis | Opus |

---

## TDD Workflow (Core)

```text
┌─────────┐     ┌─────────┐     ┌─────────┐
│   RED   │────▶│  GREEN  │────▶│REFACTOR │
│ Write   │     │ Implement│     │ Improve  │
│ Test    │     │ Code     │     │ Code     │
│ (Fail)  │     │ (Pass)   │     │ (Pass)   │
└─────────┘     └─────────┘     └─────────┘
     │                               │
     └───────────── LOOP ────────────┘
```

**Hard Requirements:**

- Minimum 80% test coverage
- Write test before code; violation = delete and restart
- Each step: write test → run → implement → run → commit

---

## Two-Stage Review System

| Stage | Focus | Gate |
|-------|-------|------|
| **Stage 1: Spec Review** | Does it match requirements? | Must pass before Stage 2 |
| **Stage 2: Code Review** | Is it well-built? | Must pass before merge |

---

## Anti-Patterns to Avoid

| Thought | Reality |
|---------|---------|
| "This is too simple for design" | Simple things are exactly when you skip design |
| "Let me just write the code first" | TDD violation - delete and restart |
| "I'll add tests later" | You won't. Write them first. |
| "The context is fine" | Fresh context per task prevents pollution |
| "I know what to do" | Still read memory-bank for latest state |

---

## Key Insight from OpenAI

> **"Building software still demands discipline, but the discipline shows up more in the scaffolding rather than the code."**

This is exactly what claude-me is building — the scaffolding (skills, hooks, MCP configs) that enables agents to work effectively.

---

## Core Principles Implementation

| Principle | Mechanism | Example |
|-----------|-----------|---------|
| **Human Plans, AI Executes** | `<HARD-GATE>`, design docs as prerequisites | Brainstorming skill forces clarifying dialog |
| **Design Before Code** | GDD/PRD in memory-bank, architect agent | AI reads design before execution |
| **Repository = Truth** | SessionStart loads memory-bank | Slack discussion not in repo = invisible |
| **Test First, Always** | TDD skill, 80% coverage | Violation = delete and restart |
| **Encode Taste into Tooling** | rules/, hooks/, linters | Found problem? Write a rule, not verbal correction |

---

## Workflow Stages

| Stage | Skill | Agent | Output |
|-------|-------|-------|--------|
| **0. INITIALIZE** | - | - | branch + feature memory |
| **1. BRAINSTORM** | `brainstorming` | `architect` | design.md |
| **2. PLAN** | `writing-plans` | `planner` | plan.md (2-5 min tasks) |
| **3. EXECUTE** | `tdd` | `tdd-guide` | code |
| **4. REVIEW** | `code-review` | `code-reviewer` | feedback |
| **5. COMMIT** | - | - | commit |
| **6. LEARN** | - | - | update memory-bank |

---

## Enforcement Layers

| Layer | Purpose | Mechanisms |
|-------|---------|------------|
| **Document** | Psychological | `<HARD-GATE>`, Checklist, Anti-Pattern Table |
| **Hook** | Automatic interception | PreToolUse, PostToolUse, SessionStart |
| **Agent** | Specialized review | code-reviewer, security-reviewer |
| **CI/CD** | Final gates | Test coverage, Security scan |

---

## Memory Bank Loading Strategy

| Layer | When to Load | Content |
|-------|--------------|---------|
| `~/.claude/memory-bank/` | Every SessionStart | Global knowledge |
| `workspace/memory-bank/{project}/CLAUDE.md` | When in project dir | Project entry |
| `workspace/memory-bank/{project}/features/{feature}/` | On feature branch | Feature design, plan, progress |
