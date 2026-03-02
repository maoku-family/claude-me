# Research: obra/superpowers

**Repository:** [obra/superpowers](https://github.com/obra/superpowers)
**Stars:** 64,380 | **Author:** Jesse Vincent (obra)
**Version:** 4.3.1 | **License:** MIT
**Research Date:** February 27, 2026

## Overview

An agentic skills framework and software development methodology for AI coding agents. Provides a complete workflow system from initial idea to deployed code.

## Core Problem It Solves

1. AI agents jump to code too quickly
2. Context pollution in long sessions
3. Lack of systematic process
4. No quality gates
5. TDD violations

## Workflow Pipeline

```text
Brainstorming → Git Worktree → Writing Plans → Subagent Development → Code Review → Branch Completion
```

## Key Skills (14 total)

| Skill | Purpose |
|-------|---------|
| **brainstorming** | Design-first with `<HARD-GATE>` |
| **using-git-worktrees** | Isolated workspaces for features |
| **writing-plans** | Bite-sized tasks (2-5 min each) |
| **subagent-driven-development** | Fresh subagent per task |
| **test-driven-development** | RED-GREEN-REFACTOR strictly enforced |
| **systematic-debugging** | Root cause first, fix second |
| **code-review** | Plan alignment + code quality |

## Hard Gate Mechanism

```markdown
<HARD-GATE>
DO NOT proceed to implementation until design is explicitly approved.
</HARD-GATE>
```

Forces AI to stop and wait for human confirmation.

## TDD Enforcement

- **Iron Law:** No production code without failing test first
- "Write code before test? Delete it. Start over."
- Explicit rationalization counters for every excuse

## Systematic Debugging

1. **Phase 1:** Root Cause Investigation (NO fixes)
2. **Phase 2:** Pattern Analysis (find working examples)
3. **Phase 3:** Hypothesis & Testing (single hypothesis)
4. **Phase 4:** Implementation (failing test first)
5. **3+ failed fixes → Question architecture**

## Two-Stage Review

| Stage | Focus | Gate |
|-------|-------|------|
| **Stage 1: Spec Review** | Does it match requirements? | Must pass before Stage 2 |
| **Stage 2: Code Review** | Is it well-built? | Must pass before merge |

## Key Takeaways for claude-me

1. **Enforce design-before-code with hard gates**
2. **Bite-sized tasks (2-5 min)** with single actions
3. **Fresh context per task** prevents pollution
4. **Two-stage review gates** (spec + quality)
5. **Explicit rationalization counters** - tables of excuses with rebuttals
6. **Skill activation via description** - "Use when..." triggers

## Recommended Adoption

| Priority | Skill | Rationale |
|----------|-------|-----------|
| High | brainstorming | Prevents premature coding |
| High | test-driven-development | Foundation for quality |
| High | writing-plans | Enables autonomous execution |
| Medium | subagent-driven-development | Manages context |
| Medium | systematic-debugging | Reduces thrashing |
| Low | using-git-worktrees | Nice isolation |
