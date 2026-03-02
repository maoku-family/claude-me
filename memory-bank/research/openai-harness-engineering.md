# Research: OpenAI Harness Engineering

**Source:** [OpenAI Engineering Blog](https://openai.com/index/harness-engineering/)
**Author:** Ryan Lopopolo, Member of Technical Staff
**Date:** February 11, 2026

## Overview

OpenAI built and shipped an internal beta with **0 lines of manually-written code** over 5 months.

> Humans steer. Agents execute.

## Results

- ~1 million lines of code
- ~1,500 pull requests
- 3.5 PRs per engineer per day
- Small team of 3 engineers (now 7)
- Estimated **1/10th the time** vs manual coding

## Key Insight: AGENTS.md as Table of Contents

**Problem with "one big AGENTS.md":**

- Context is scarce - crowds out the task
- Too much guidance becomes non-guidance
- It rots instantly
- Hard to verify

### Solution: ~100 lines as index

```text
AGENTS.md
ARCHITECTURE.md
docs/
├── design-docs/
├── exec-plans/
│   ├── active/
│   ├── completed/
│   └── tech-debt-tracker.md
├── generated/
├── product-specs/
├── research/
├── DESIGN.md
├── FRONTEND.md
├── PLANS.md
├── PRODUCT_SENSE.md
├── QUALITY_SCORE.md
├── RELIABILITY.md
└── SECURITY.md
```

**Progressive disclosure**: agents start with a small, stable entry point and are taught where to look next.

## Agent Legibility

> Anything the agent can't access in-context while running effectively doesn't exist.

- Knowledge in Google Docs, chat threads, or people's heads = inaccessible
- Repository-local, versioned artifacts = all it can see

> That Slack discussion that aligned the team? If it isn't in repo, it's illegible.

## Enforcing Architecture and Taste

- Each domain divided into fixed layers: Types → Config → Repo → Service → Runtime → UI
- Custom linters with error messages that inject remediation instructions
- Human taste fed back continuously via doc updates or encoded into tooling

## Throughput Philosophy

- Minimal blocking merge gates
- Short-lived pull requests
- Test flakes addressed with follow-up runs

> In a system where agent throughput exceeds human attention, corrections are cheap, and waiting is expensive.

## Increasing Autonomy

Single prompt can now:

1. Validate current state
2. Reproduce reported bug
3. Record video of failure
4. Implement fix
5. Validate fix by driving application
6. Record video of resolution
7. Open PR
8. Respond to feedback
9. Detect and remediate build failures
10. Escalate to human only when needed
11. Merge the change

## Entropy and Garbage Collection

- Codex replicates patterns that exist - even suboptimal ones
- Solution: "Golden principles" + recurring cleanup

> Technical debt is like a high-interest loan: it's almost always better to pay it down continuously in small increments.

## Key Quote

> Building software still demands discipline, but the discipline shows up more in the **scaffolding** rather than the code.

This is exactly what claude-me is building - the scaffolding (skills, hooks, MCP configs) that enables agents to work effectively.
