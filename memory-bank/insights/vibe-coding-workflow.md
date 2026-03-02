# Insight: Vibe-Coding Workflow

**Date:** 2026-02-27

**Sources:**

- [Research: EnzeD/vibe-coding](../research/vibe-coding.md)
- [Research: obra/superpowers](../research/superpowers.md)
- [Research: affaan-m/everything-claude-code](../research/everything-claude-code.md)
- [Research: Community Resources](../research/community-resources.md)
- [Research: OpenAI Harness Engineering](../research/openai-harness-engineering.md)

---

## Summary

Effective AI-assisted development ("vibe coding") requires shifting discipline from code to scaffolding. Research across multiple projects reveals a consistent pattern: human-driven design with AI execution, enforced through TDD, multi-agent orchestration, and layered gates (documents → hooks → agents → CI). The key insight from OpenAI—"discipline shows up more in scaffolding rather than the code"—validates claude-me's architecture of skills, hooks, and rules as the primary mechanism for quality control.

## Key Findings

| # | Finding |
|---|---------|
| 1 | Design-first enforcement via `<HARD-GATE>` patterns prevents premature coding |
| 2 | TDD with 80% coverage minimum; violation = delete and restart (non-negotiable) |
| 3 | 2-5 minute granular tasks enable independent subagent execution |
| 4 | Two-stage review (spec review → code review) catches both "what" and "how" issues |
| 5 | Memory-bank loading at session start ensures context continuity across sessions |
| 6 | Hooks (PreToolUse, PostToolUse) provide automatic safety guards and formatting |
| 7 | Anti-patterns ("too simple for design", "tests later") require explicit documentation |
| 8 | Fresh context per task prevents state pollution between executions |

## Implications for claude-me

This research validates our core architecture. The five principles (Human Plans/AI Executes, Design Before Code, Repo=Truth, Test First, Encode Taste) align directly with community best practices. The scaffolding approach means our `skills/`, `hooks/`, and `rules/` directories are the primary quality control mechanisms—not verbal corrections or post-hoc reviews. When problems arise, the fix is a new rule or hook, not a conversation.

## Recommendations

| Priority | Recommendation | Rationale |
|----------|----------------|-----------|
| 🔴 HIGH | Implement `brainstorming` skill with `<HARD-GATE>` | Forces design-first; blocks coding before spec |
| 🔴 HIGH | Implement `test-driven-development` skill | Enforces TDD workflow with delete-on-violation |
| 🔴 HIGH | Implement `writing-plans` skill | Generates 2-5 min tasks for subagent execution |
| 🔴 HIGH | Add PreToolUse hook for dangerous ops | Safety guard before destructive commands |
| 🟡 MED | Implement `subagent-driven-development` skill | Independent context per task |
| 🟡 MED | Add SessionStart hook for memory-bank loading | Automatic context restoration |
| 🟡 MED | Create `code-reviewer` and `security-reviewer` agents | Specialized review with Opus model |
| 🟢 LOW | Implement `using-git-worktrees` skill | Feature isolation for parallel work |
| 🟢 LOW | Add PostToolUse hook for auto-formatting | Consistent code style without manual effort |

---

## Appendix: Workflow Architecture

```text
INITIALIZE → BRAINSTORM → PLAN → EXECUTE → REVIEW → COMMIT → LEARN
   │            │           │        │         │        │        │
   │         architect    planner   TDD    code-rev   hook    memory
   │                                        security          bank
   └─ SessionStart hook loads memory-bank
```

**Workflow Stages:**

| Stage | Skill | Agent | Output |
|-------|-------|-------|--------|
| 0. INITIALIZE | - | - | branch + feature memory |
| 1. BRAINSTORM | `brainstorming` | `architect` | design.md |
| 2. PLAN | `writing-plans` | `planner` | plan.md (2-5 min tasks) |
| 3. EXECUTE | `tdd` | `tdd-guide` | code |
| 4. REVIEW | `code-review` | `code-reviewer` | feedback |
| 5. COMMIT | - | - | commit |
| 6. LEARN | - | - | update memory-bank |

**Enforcement Layers:**

| Layer | Purpose | Mechanisms |
|-------|---------|------------|
| Document | Psychological | `<HARD-GATE>`, checklists, anti-patterns |
| Hook | Automatic interception | PreToolUse, PostToolUse, SessionStart |
| Agent | Specialized review | code-reviewer, security-reviewer |
| CI/CD | Final gates | Test coverage, security scan |
