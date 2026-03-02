# Research: EnzeD/vibe-coding

**Date:** 2026-02-27

**Source:** <https://github.com/EnzeD/vibe-coding>

---

## Overview

A methodology guide for "vibe coding" - development where AI agents do the coding while humans focus on planning, validation, and direction. Centers on a `memory-bank/` folder containing GDD/PRD, tech-stack.md, implementation-plan.md, progress.md, and architecture.md.

## Key Findings

- **Two-Phase Workflow:** Human-led planning → AI-led execution with human validation
- **Memory Bank Pattern:** Persistent docs solve context loss across sessions
- **Small Steps:** Each implementation step must be testable and validatable
- **Fresh Context:** Clear chat between major steps to avoid context pollution
- **Git as Checkpoint:** Commit after each successful step

## Strengths

- Clear separation of human planning vs AI execution
- Memory bank solves the context window problem elegantly
- Step-by-step approach reduces errors and enables rollback
- Simple, no tooling required beyond Claude Code + git

## Weaknesses

- Manual process - no automation for prompt sequences
- No test framework integration
- Single-developer focus - no team workflows
- No CI/CD integration

## Takeaways for claude-me

1. **Memory Bank is Essential** - Already adopted in our architecture
2. **"Always" Rules in CLAUDE.md** - Critical guidelines auto-loaded
3. **Human Plans, AI Executes** - Core principle #1
4. **Small Steps with Tests** - Aligns with TDD principle
5. **Git Checkpoint Pattern** - Commit after each successful step
6. **Opportunities:** Add automation layer, test framework integration, team workflows
