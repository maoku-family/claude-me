# Research: EnzeD/vibe-coding

**Repository:** [EnzeD/vibe-coding](https://github.com/EnzeD/vibe-coding)
**Stars:** 3,978 | **Author:** Nicolas Zullo (@NicolasZu)
**Research Date:** February 27, 2026

## Overview

A comprehensive methodology guide for "vibe coding" - development where AI agents do the coding while humans focus on planning, validation, and direction.

## Core Concept: Memory Bank

The centerpiece is a `memory-bank/` folder containing:

- `game-design-document.md` (or PRD for apps)
- `tech-stack.md` - Technology choices and rationale
- `implementation-plan.md` - Step-by-step instructions with tests
- `progress.md` - Completed work tracking
- `architecture.md` - File structure documentation

## Workflow

### Phase 1: Planning (Human-Led)

1. Create GDD/PRD
2. Define tech stack ("simplest yet most robust")
3. Generate Implementation Plan with small, testable steps
4. Set up "Always" rules in CLAUDE.md

### Phase 2: Execution (AI-Led, Human-Validated)

1. AI reads all memory-bank documents before each task
2. Execute one step at a time
3. Human runs tests and validates
4. AI updates progress.md and architecture.md
5. Commit to git, start fresh chat (clear context)

## Key Principles

| Principle | Description |
|-----------|-------------|
| **Planning is everything** | Never let AI plan autonomously |
| **Modularity over monolith** | Enforce multiple files |
| **Small steps with tests** | Each step must be validatable |
| **Fresh context** | Clear chat between major steps |
| **Document everything** | Progress and architecture files |

## Prompt Patterns

**First Implementation:**

```text
Read all the documents in /memory-bank, and proceed with Step 1.
I will run the tests. Do not start Step 2 until I validate.
Once validated, update progress.md and architecture.md.
```

**Continuation:**

```text
Read all files in memory-bank, read progress.md to understand prior work,
and proceed with Step 2. Do not start Step 3 until I validate.
```

## Key Takeaways for claude-me

1. **Memory Bank is Essential** - Solves context loss across sessions
2. **"Always" Rules Matter** - Critical guidelines auto-loaded
3. **Human Plans, AI Executes** - Core principle
4. **Small Steps with Tests** - Each step validatable
5. **Fresh Context Strategy** - Clear context between major steps
6. **Git as Checkpoint System** - Commit after each successful step

## Improvements We Can Make

1. Automation layer for prompt sequences
2. Test framework integration (Jest, Vitest)
3. CI/CD integration
4. Team workflows
5. Template library for common project types
