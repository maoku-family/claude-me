# Workflow Rules

## Development Flow

Follow superpowers workflow for all feature development:

```text
BRAINSTORM → PLAN → EXECUTE → FINISH
```

## Before Execution

**When user approves a plan, BEFORE starting execution:**

1. Run `/plan` to initialize planning-with-files
2. This creates: `task_plan.md`, `findings.md`, `progress.md`
3. Then proceed with `subagent-driven-development`

## During Execution

planning-with-files rules apply:

| Rule | Description |
|------|-------------|
| **2-Action Rule** | Save findings after every 2 view/search operations |
| **Log ALL Errors** | Record failures to progress.md |
| **Never Repeat Failures** | `next_action != same_action` |
| **3-Strike Protocol** | Escalate to user after 3 failed attempts |

## Checkpoint

Before marking execution complete, verify:

- [ ] All tasks in plan.md marked complete
- [ ] All phases in task_plan.md marked complete
- [ ] Errors logged in progress.md
- [ ] Key findings saved in findings.md
