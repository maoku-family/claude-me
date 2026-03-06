# Development Workflow

## Overview

All feature development follows a mandatory 6-stage workflow powered by superpowers plugin.

## The Workflow

```text
BRAINSTORM → WORKTREE → PLAN → EXECUTE → REVIEW → FINISH
     1           2         3        4         5        6
```

| Stage | Skill/Agent | Output |
|-------|-------------|--------|
| BRAINSTORM | `brainstorming` | design.md |
| WORKTREE | `using-git-worktrees` | Isolated workspace |
| PLAN | `writing-plans` | plan.md |
| EXECUTE | `subagent-driven-development` | Working code |
| REVIEW | `code-reviewer` agent | Verified implementation |
| FINISH | `finishing-a-development-branch` | Merge/PR |

## Key Integrations

### superpowers

Core workflow engine providing all stage skills:

- Brainstorming with multiple choice questions
- Planning with bite-sized TDD tasks
- Subagent-driven execution with two-stage review
- Structured finish options (merge/PR/keep/discard)

### planning-with-files

Runtime context management during EXECUTE stage:

| File | Purpose |
|------|---------|
| `task_plan.md` | Phase tracking (auto-read by PreToolUse hook) |
| `findings.md` | Research discoveries |
| `progress.md` | Session log |

These files live in worktree root during execution, then archive to memory-bank.

### ralph-wiggum

Autonomous execution mode:

- Wraps `subagent-driven-development` in a loop
- No human intervention required
- Use when user is away

## File Locations

| File | During Work | After FINISH |
|------|-------------|--------------|
| design.md | `memory-bank/{project}/features/{name}/` | Same |
| plan.md | `memory-bank/{project}/features/{name}/` | Same |
| task_plan.md | worktree root | Archived to memory-bank |
| findings.md | worktree root | Archived to memory-bank |
| progress.md | worktree root | Archived to memory-bank |

## Execution Modes

| Mode | Command | When |
|------|---------|------|
| Supervised | Invoke `subagent-driven-development` | User present |
| Autonomous | `/ralph-loop` with subagent-driven-development | User away |

## Related Documentation

| Document | Content |
|----------|---------|
| [../rules/workflow.md](../rules/workflow.md) | Detailed rules and gates |
| [architecture.md](architecture.md) | System architecture |
