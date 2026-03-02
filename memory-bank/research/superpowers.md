# Research: obra/superpowers

**Date:** 2026-02-27

**Source:** <https://github.com/obra/superpowers>

---

## Overview

An agentic skills framework and software development methodology for AI coding agents. Provides a complete workflow system from initial idea to deployed code through a pipeline: Brainstorming → Git Worktree → Writing Plans → Subagent Development → Code Review → Branch Completion.

## Key Findings

- **Hard Gate Mechanism**: `<HARD-GATE>` blocks force AI to stop and wait for human confirmation before implementation
- **14 Skills**: brainstorming, using-git-worktrees, writing-plans, subagent-driven-development, test-driven-development, systematic-debugging, code-review, etc.
- **Bite-sized Tasks**: 2-5 minute tasks with single actions prevent context pollution
- **Two-Stage Review**: Spec review (does it match requirements?) → Code review (is it well-built?)
- **TDD Iron Law**: No production code without failing test first. "Write code before test? Delete it."
- **Systematic Debugging**: 5-phase process (Root Cause → Pattern Analysis → Hypothesis → Testing → Implementation). 3+ failed fixes = question architecture

## Strengths

- Prevents premature coding through explicit design gates
- Fresh subagent per task manages context effectively
- Explicit rationalization counters (tables of excuses with rebuttals) for TDD enforcement
- Skill activation via "Use when..." triggers in descriptions

## Weaknesses

- Heavy process overhead for simple changes
- Requires discipline to follow all phases
- Git worktree workflow adds complexity

## Takeaways for claude-me

1. **Enforce design-before-code with hard gates** - `<HARD-GATE>` pattern for critical decisions
2. **Bite-sized tasks (2-5 min)** - Single action per task prevents pollution
3. **Two-stage review gates** - Spec compliance first, then code quality
4. **Explicit rationalization counters** - Preempt common excuses with rebuttals
5. **Skill activation via description** - "Use when..." triggers for discoverability
