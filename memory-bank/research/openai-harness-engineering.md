# Research: OpenAI Harness Engineering

**Date:** 2026-02-11

**Source:** [OpenAI Engineering Blog](https://openai.com/index/harness-engineering/)

---

## Overview

OpenAI shipped an internal beta with **0 lines of manually-written code** over 5 months using a small team (3→7 engineers). Core philosophy: "Humans steer. Agents execute."

## Key Findings

- ~1M lines of code, ~1,500 PRs (3.5 PRs/engineer/day)
- Estimated 1/10th time vs manual coding
- AGENTS.md as ~100-line index (not monolithic instructions)
- Progressive disclosure: small stable entry point → deeper docs
- Repository-local artifacts = only thing agents can access
- Custom linters inject remediation instructions
- Minimal blocking gates; corrections cheap, waiting expensive

## Strengths

- Clear layered architecture (Types → Config → Repo → Service → Runtime → UI)
- Agents can handle full workflow: reproduce bug → fix → validate → PR → merge
- Technical debt paid continuously in small increments
- Human taste encoded into tooling, not just documentation

## Weaknesses

- Requires significant upfront investment in scaffolding
- "Codex replicates patterns that exist - even suboptimal ones" (entropy)
- Knowledge in Slack/Docs/heads = invisible to agents

## Takeaways for claude-me

1. **CLAUDE.md as index** - Keep ~100 lines, link to deeper docs
2. **Progressive disclosure** - Already a core principle; validate approach
3. **Encode taste into tooling** - Linters, hooks, skills > documentation
4. **Repository = truth** - If it's not in repo, it doesn't exist for agents
5. **Scaffolding > code** - Discipline shows in skills/hooks/configs, not manual code
