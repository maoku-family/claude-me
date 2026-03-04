# Documentation Sync Rules

## Keep Docs in Sync

**After ANY insight or change, update relevant documentation:**

| Change Type | Update |
|-------------|--------|
| New directory/file | CLAUDE.md Directory Structure |
| New script/tool | memory-bank/architecture.md |
| New skill | memory-bank/architecture.md, skills/README.md (Structure) |
| Skill modification | skills/README.md (Changelog) |
| Skill feature added/fixed | skills/README.md (Changelog) |
| Skill planned feature | skills/README.md (Todo) |
| Lint config change | memory-bank/lint.md |
| Tech stack change | memory-bank/stack.md |
| New convention/pattern | Relevant memory-bank/ file |
| Project insight | memory-bank/ or CLAUDE.md |

## Checklist

Before completing any task, ask:

1. Did I learn something new about this project?
2. Did I create/modify/delete any files?
3. Did I discover a new pattern or convention?

If YES to any → Update the relevant documentation.

## Examples

| Insight | Action |
|---------|--------|
| "tests/ also has skills.bats" | Update architecture.md Tests section |
| "shfmt reads from .editorconfig" | Update lint.md |
| "hooks use CLAUDE_PLUGIN_ROOT" | Update architecture.md Hooks section |
| "progressive disclosure works well" | Already in Core Principles ✓ |
| "added Check Progress to labs-content-update" | Update skills/README.md Changelog |
| "want to add batch operations to skill" | Update skills/README.md Todo |
| "created new skill for X" | Update skills/README.md Structure + Changelog |
