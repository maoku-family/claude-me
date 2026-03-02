# Research: Writing a Good CLAUDE.md

**Date:** 2026-02-28

**Source:** [HumanLayer Blog](https://www.humanlayer.dev/blog/writing-a-good-claude-md)

---

## Overview

LLMs are stateless functions with frozen weights. The only thing Claude knows about your codebase is the tokens you put into it. CLAUDE.md is the **highest-leverage configuration point**.

## Key Findings

- **Three Dimensions Framework:** WHAT (technical stack), WHY (project purpose), HOW (practical instructions)
- Claude Code injects: "this context may or may not be relevant to your tasks" — only **universally applicable** content survives
- Frontier LLMs reliably follow **150-200 instructions**; Claude Code's system prompt uses ~50
- Target **< 100 lines** (some teams use < 60 lines)
- "Prefer pointers to copies" — file references don't get outdated
- Never use LLMs for code style enforcement — use linters and hooks
- Avoid `/init` auto-generation; a bad line affects every workflow

## Strengths

- Clear, actionable framework (WHAT/WHY/HOW)
- Specific limits (150-200 instructions, <100 lines)
- Progressive disclosure pattern aligns with information architecture best practices

## Weaknesses

- No guidance on multi-repo or monorepo scenarios
- Doesn't address CLAUDE.md versioning or evolution over time
- Limited discussion of rules/ vs CLAUDE.md trade-offs

## Takeaways for claude-me

1. **Keep CLAUDE.md minimal** — currently ~90 lines, within target
2. **Use memory-bank/ for details** — already doing progressive disclosure
3. **Use rules/ for standards** — auto-loaded, keeps CLAUDE.md focused
4. **Avoid duplicating content** — link to memory-bank/ files instead
5. **Review periodically** — prune instructions that aren't universally applicable
