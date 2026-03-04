---
name: labs-content-update
description: Use when updating labs-content experiment configs, syncing schema changes from Studio PRs, publishing to staging/production, checking progress, or listing/viewing experiments. Triggers on "update labs content", "sync schema from studio", "publish staging", "publish production", "labs 进度", "check labs progress", "resume labs update", "list experiments", "列出实验", "show experiment", "查看实验".
---

# Labs Content Update

## Overview

Workflow for updating Copilot Labs experiment configurations, syncing schema changes from Studio repository, and publishing through the pipeline.

## When to Use

- Updating experiment metadata (title, description, links, covers)
- Syncing schema changes from `infinity-microsoft/studio` PRs
- Adding new experiments
- Disabling/enabling experiments
- Publishing content to staging or production
- **Checking progress** of an in-flight update
- **Resuming** a partially completed workflow

## First: Ask What Type of Update

**ALWAYS ask the user which operation they need:**

| Operation | Files to Modify | Special Steps |
|-----------|-----------------|---------------|
| **Add new experiment** | Create `content/original/{name}/` with metadata.json + landing-page.md, update `settings.json` | Allocate new ID |
| **Modify experiment** | Edit `content/original/{name}/metadata.json` or `landing-page.md` | None |
| **Sync schema from Studio** | Update `config.schema.json` + `metadata.schema.json` | Read via `gh api` |
| **Disable/Enable experiment** | Set `enabled` in `settings.json` | Content stays intact |
| **Update covers/media** | Edit `covers` array in metadata.json | Use predictable CDN URL |
| **Check progress / Resume** | N/A | Detect state from GitHub |
| **List experiments** | N/A | Read settings.json + metadata |
| **View experiment details** | N/A | Read metadata.json + landing-page.md |

## Content Pipeline

```text
original/ → generated/ → dist/ → publish
```

| Stage | Directory | Description |
|-------|-----------|-------------|
| Source | `content/original/{experiment}/` | metadata.json + landing-page.md |
| Build | `content/generated/` | Intermediate configs |
| Release | `content/dist/` | Merged configs by locale |
| Publish | picasso-assets / studio | CDN and frontend repos |

## List Experiments

**When user asks:** "列出所有实验", "list experiments", "show labs"

```bash
# Read settings.json for IDs and enabled status
cat workspace/repos/labs-content/settings.json | jq '.experiments'

# Quick summary: read all metadata.json files
for dir in workspace/repos/labs-content/content/original/*/; do
  name=$(basename "$dir")
  jq -r --arg alias "$name" '"\(.name) | \(.type) | \(.status)"' "$dir/metadata.json" 2>/dev/null
done
```

### List View Format

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                          Copilot Labs Experiments                           │
├────┬───────────────────────────┬─────────┬───────────┬─────────┬────────────┤
│ ID │ Alias                     │ Type    │ Status    │ Enabled │ Name       │
├────┼───────────────────────────┼─────────┼───────────┼─────────┼────────────┤
│  0 │ copilot-vision            │ FEATURE │ LIVE      │ ✅      │ Copilot... │
│  1 │ copilot-gaming-experiences│ PROJECT │ LIVE      │ ✅      │ Copilot... │
└────┴───────────────────────────┴─────────┴───────────┴─────────┴────────────┘

Summary: N experiments (X enabled, Y disabled)
         FEATURE: X | PROJECT: Y
         LIVE: X | GRADUATED: Y | NOTSET: Z
```

## View Experiment Details

**When user asks:** "查看 copilot-vision 详情", "show experiment X", "details of X"

```bash
# Read metadata.json
cat workspace/repos/labs-content/content/original/{alias}/metadata.json | jq .

# Read landing page
cat workspace/repos/labs-content/content/original/{alias}/landing-page.md
```

### Rendering Cover Images (Detail View Only)

**Only render images/videos when viewing experiment details, NOT in list view.**

To show cover images in the detail view:

1. Extract cover URL from metadata.json
2. List covers with their URLs, types, sizes, and consumers

### Detail View Format

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│ {alias}                                                                     │
├─────────────┬───────────────────────────────────────────────────────────────┤
│ ID          │ {id}                                                          │
│ Enabled     │ ✅/❌                                                          │
│ Name        │ {name}                                                        │
│ Type        │ FEATURE/PROJECT                                               │
│ Status      │ LIVE/GRADUATED/NOTSET/...                                     │
│ Order       │ {order}                                                       │
│ isMaster    │ true/false                                                    │
└─────────────┴───────────────────────────────────────────────────────────────┘

Description:
┌───────┬─────────────────────────────────────────────────────────────────────┐
│ Title │ {title}                                                             │
│ Short │ {short description}                                                 │
│ Long  │ {filename} (see Landing Page below)                                 │
└───────┴─────────────────────────────────────────────────────────────────────┘

Covers:
┌───────┬───────────┬──────────────┬──────────────────────────────────────────┐
│ Type  │ Size      │ Consumers    │ URL                                      │
├───────┼───────────┼──────────────┼──────────────────────────────────────────┤
│ IMAGE │ 643×360   │ HOMEPAGE     │ https://...                              │
│ VIDEO │ 1920×930  │ LANDING_PAGE │ https://...                              │
└───────┴───────────┴──────────────┴──────────────────────────────────────────┘

Links:
┌──────────────┬────────────────┬───────────────────────┬────────┐
│ Type         │ Trigger        │ Target                │ Scopes │
├──────────────┼────────────────┼───────────────────────┼────────┤
│ PROJECT_LINK │ TRY_NOW_BUTTON │ /labs/{alias}         │ ALL    │
└──────────────┴────────────────┴───────────────────────┴────────┘

Files:
content/original/{alias}/
├── metadata.json
└── landing-page.md

Landing Page:
{content of landing-page.md in markdown code block}
```

## Check Progress / Resume Workflow

**When user asks:** "进度如何", "继续", "check progress", "resume"

Run these commands to detect current state:

```bash
# 1. Check for open labs-content PRs
gh pr list --repo infinity-microsoft/labs-content --state open --json number,title,headRefName,url

# 2. Check for recent merged PRs (last 7 days)
gh pr list --repo infinity-microsoft/labs-content --state merged --search "merged:>$(date -v-7d +%Y-%m-%d)" --json number,title,mergedAt,url

# 3. Check release branches
git fetch origin && git branch -r | grep release | tail -3

# 4. Check recent workflow runs
gh run list --repo infinity-microsoft/labs-content --limit 5 --json databaseId,name,status,conclusion,headBranch,createdAt

# 5. Check picasso-assets PRs and their changed files
gh pr list --repo infinity-microsoft/picasso-assets --state all --search "labs" --limit 5 --json number,title,state,mergedAt,url,files

# 6. Check studio open PRs (from labs-content)
gh pr list --repo infinity-microsoft/studio --state open --search "labs" --json number,title,url
```

### Distinguish Staging vs Production PRs

For picasso-assets PRs, check the `files` field:

| Changed File | PR Type |
|--------------|---------|
| `staging.config.json` | Staging (Step 12) |
| `prod.config.json` | Production (Step 17) |

If `--json files` is not supported, use per-PR query:

```bash
# Get files changed in a specific PR
gh pr view <pr-number> --repo infinity-microsoft/picasso-assets --json files --jq '.files[].path'
```

### State Detection Matrix

| Detected State | Current Step | Next Action |
|----------------|--------------|-------------|
| Open PR in labs-content | 7 | Wait for merge, or remind user to review |
| PR merged, no release branch newer than merge | 9 | Wait for Release workflow |
| Release branch exists, no staging workflow run | 10 | Trigger Publish: Staging |
| Staging workflow running | 10 | Wait for workflow to complete |
| Staging workflow completed, no staging PR in picasso | 11 | Check workflow logs for error |
| Open PR in picasso-assets (staging) | 12 | Wait for merge or auto-merge |
| Staging PR merged, no production workflow | 14 | Ask user to verify staging, then trigger production |
| Production workflow running | 15 | Wait for workflow to complete |
| Production workflow completed (picasso PR + studio PR created) | 16 | Check both PRs |
| Open PR in picasso-assets (production), studio PR open | 17 | Wait for picasso PR merge |
| picasso PR (production) merged, studio PR open | 18-19 | User verify, remind to merge studio PR |
| picasso PR merged, studio PR merged | Done | ✅ Complete |

### Progress Report Format

After detecting state, report to user:

```text
## Labs Content Update Progress

**Operation:** [Add/Modify/Schema Sync] - [experiment name or description]
**Started:** [date from first PR or branch]

### Current Status
- Step [N]/19: [Step description]
- Status: [Waiting/In Progress/Blocked/Ready]

### Pending Items
| Item | Status | Action Needed |
|------|--------|---------------|
| labs-content PR #123 | Merged ✅ | - |
| Release workflow | Completed ✅ | - |
| Publish: Staging workflow | Completed ✅ | - |
| picasso-assets PR (staging) | Merged ✅ | - |
| Publish: Production workflow | Completed ✅ | - |
| picasso-assets PR (production) | Merged ✅ | 线上已生效 |
| studio PR | Open ⏳ | 可异步 merge |

### Next Step
[Describe what to do next]
```

## Complete Workflow

| Step | Action | State Indicator |
|------|--------|-----------------|
| 0 | Check if Studio schema needs sync | - |
| 1 | Collect info: what to update, new values | - |
| 2 | Sync schema if needed | Local files changed |
| 3 | Edit files based on user input | Local files changed |
| 4 | Run `npm run test:integration` | Tests pass |
| 5 | Update baselines if needed | Tests pass |
| 6 | Create branch, commit, push, create PR | PR open in labs-content |
| 7 | Tell user PR URL, remind to merge | PR open |
| 8 | Watch PR until merged (poll every 1 hour, auto-merge if approved) | PR merged |
| 9 | Watch Release workflow until complete | Release branch exists |
| **Staging** | | |
| 10 | Trigger Publish: Staging | Staging workflow running |
| 11 | Watch Staging workflow, tell user picasso-assets PR URL | Staging workflow done |
| 12 | Watch picasso-assets PR until merged | picasso PR merged |
| 13 | Tell user to verify at <https://www.copilot-stg.com/labs> | User confirms |
| 14 | Ask: "Staging verified. Publish to Production?" | User confirms |
| **Production** | | |
| 15 | Trigger Publish: Production | Production workflow running |
| 16 | Watch Production workflow (creates BOTH picasso PR + studio PR) | Production workflow done |
| 17 | Watch picasso-assets PR (production) until merged | picasso PR merged → **线上生效** |
| 18 | Tell user to verify at <https://www.copilot.microsoft.com/labs> | User confirms |
| 19 | Remind user to merge studio PR (i18n + fallback, 可异步) | studio PR merged |

### Watch PR / Workflow Commands

```bash
# Check PR state and auto-merge if ready
gh pr view <pr-number> --repo <repo> --json state,mergedAt,reviewDecision,mergeable
gh pr merge <pr-number> --repo <repo> --merge  # If approved + mergeable

# Watch workflow until complete
gh run list --repo <repo> --workflow "<workflow-name>" --limit 1 --json databaseId --jq '.[0].databaseId'
gh run watch <run-id> --repo <repo>
```

## Repositories and Workflows

| Repo | Purpose |
|------|---------|
| `infinity-microsoft/labs-content` | Content source |
| `infinity-microsoft/picasso-assets` | CDN assets |
| `infinity-microsoft/studio` | Frontend (schema source + production target) |

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `Release` | Auto on push to main | Creates release branch with dist/ |
| `Publish: Staging` | Manual on release/* | Syncs to picasso-assets staging |
| `Publish: Production` | Manual on release/* | Syncs to picasso-assets + studio prod |

## Quick Reference

| File | Purpose |
|------|---------|
| `content/original/{exp}/metadata.json` | Experiment configuration |
| `content/original/{exp}/landing-page.md` | Landing page content |
| `content/config.schema.json` | Schema for generated configs |
| `content/metadata.schema.json` | Schema for source metadata |
| `settings.json` | Experiment IDs and enabled flags |

```bash
npm run test:integration                    # Run tests
npm run test:update-integration-baselines   # Update baselines
```

## Schema Sync from Studio

```bash
# Read schema file directly
gh api repos/infinity-microsoft/studio/contents/src/schemas/labs-schemas.ts \
  --jq '.content' | base64 -d
```

**Zod to JSON Schema mapping:**

- `z.enum([...])` → `"enum": [...]`
- `z.literal("X")` → `"const": "X"`
- `z.union([A, B])` → `"oneOf": [{...}, {...}]`
- `z.object({...}).extend({...})` → `"allOf": [{...}, {...}]`

Update both `config.schema.json` and `metadata.schema.json`, then update affected experiments.

## Add New Experiment

**Ask user for:**

1. Experiment name (e.g., "Copilot Vision")
2. Alias (URL slug, e.g., "copilot-vision")
3. Type: FEATURE or PROJECT
4. Status: UPCOMING, LIVE, GRADUATED, etc.
5. Short description (1-2 sentences)
6. Landing page content (can be placeholder)
7. Cover image URL
8. Try Now button URL

**Then:**

1. Create `content/original/{alias}/metadata.json` and `landing-page.md`
2. Register in `settings.json` with new ID (highest + 1), `enabled: true`
3. Run tests and update baselines

### metadata.json Template

```json
{
  "name": "Experiment Display Name",
  "alias": "experiment-alias",
  "type": "FEATURE",
  "status": "UPCOMING",
  "assets": {
    "descriptions": {
      "title": { "stringValue": "Display Name", "i18nKey": "labs.experimentsAssets.experimentAlias.title" },
      "short": { "stringValue": "Brief description.", "i18nKey": "labs.experimentsAssets.experimentAlias.shortDescription" },
      "long": { "filename": "labs-exp-experiment-alias" }
    },
    "covers": [{ "type": "IMAGE", "url": "https://copilot.microsoft.com/static/copilotlabs/cover.jpg", "consumers": ["HOMEPAGE"] }],
    "links": [{ "type": "EXTERNAL_LINK", "trigger": "TRY_NOW_BUTTON", "url": "https://example.com", "stringValue": "Try now", "i18nKey": "labs.experimentsAssets.experimentAlias.tryNowButton" }],
    "layouts": { "order": 10 }
  }
}
```

| Field | Values |
|-------|--------|
| `type` | `FEATURE`, `PROJECT` |
| `status` | `NOTSET`, `REGISTERED`, `UPCOMING`, `LIVE`, `GRADUATED`, `SUNSETTED` |

## Disable/Enable Experiment

Edit `settings.json`: set `"enabled": false` (or `true`). Content stays intact, just excluded from dist.

## Modify Experiment

**Ask:** Which experiment? What to modify?

| Change | File |
|--------|------|
| Title, description, links, status | `metadata.json` |
| Landing page content | `landing-page.md` |

## Update Covers/Media

Place media in `content/original/{exp}/`, update `covers` array with predictable CDN URL:

```text
https://copilot.microsoft.com/static/copilotlabs/{filename}
```

Use `--sync-media` flag with Publish: Staging to sync media files.

| Type | Fields | Consumers |
|------|--------|-----------|
| IMAGE | `type`, `url`, `consumers` | HOMEPAGE, LANDING_PAGE |
| VIDEO | `type`, `url`, `width`, `height`, `consumers` | HOMEPAGE, LANDING_PAGE |

Supported: .png, .jpg, .jpeg, .gif, .webp, .svg, .mp4, .webm, .mov

## Publishing

*_CRITICAL: Use release/_ branch, NOT main**

```bash
# Find latest release branch
git fetch origin && git branch -r | grep release | tail -1

# Trigger workflows
gh workflow run "Publish: Staging" --repo infinity-microsoft/labs-content --ref release/YYYY-MM-DD-HHMMSS
gh workflow run "Publish: Production" --repo infinity-microsoft/labs-content --ref release/YYYY-MM-DD-HHMMSS
```

| Environment | Publishes To |
|-------------|--------------|
| Staging | picasso-assets (`staging.config.json` + media with `--sync-media`) |
| Production | picasso-assets (`prod.config.json`) + studio (markdown, strings, fallback) |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Run Publish on `main` branch | Use `release/*` branch - main has no `dist/` |
| Push directly to main | Create feature branch and PR |
| Forget to update baselines | Run `npm run test:update-integration-baselines` |
| Miss schema file | Update BOTH `config.schema.json` AND `metadata.schema.json` |

## Troubleshooting

### Staging workflow fails with "content/dist is empty"

**Cause**: Publish workflow ran on `main` branch, but `dist/` only exists on `release/*` branches.

**Fix**: Find the latest release branch and run Publish on that branch:

```bash
git fetch origin && git branch -r | grep release | tail -1
gh workflow run "Publish: Staging" --repo infinity-microsoft/labs-content --ref release/YYYY-MM-DD-HHMMSS
```

## Checklist

- [ ] Create feature branch (not direct to main)
- [ ] Update schema files (if schema change)
- [ ] Update experiment metadata
- [ ] Run `npm run test:integration`
- [ ] Update baselines if needed
- [ ] Commit and create PR
- [ ] After merge, find release branch
- [ ] Trigger Publish: Staging on release branch
- [ ] Verify staging
- [ ] Trigger Publish: Production on release branch
