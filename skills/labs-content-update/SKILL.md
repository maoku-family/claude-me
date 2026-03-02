---
name: labs-content-update
description: Use when updating labs-content experiment configs, syncing schema changes from Studio PRs, or publishing to staging/production. Triggers on "update labs content", "sync schema from studio", "publish staging", "publish production".
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

## First: Ask What Type of Update

**ALWAYS ask the user which operation they need:**

| Operation | Files to Modify | Special Steps |
|-----------|-----------------|---------------|
| **Add new experiment** | Create `content/original/{name}/` with metadata.json + landing-page.md, update `settings.json` | Allocate new ID |
| **Modify experiment** | Edit `content/original/{name}/metadata.json` or `landing-page.md` | None |
| **Sync schema from Studio** | Update `config.schema.json` + `metadata.schema.json` | Read via `gh api` |
| **Disable/Enable experiment** | Set `enabled` in `settings.json` | Content stays intact |
| **Update covers/media** | Edit `covers` array in metadata.json | Use predictable CDN URL |

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

## Complete Workflow

| Step | Action |
|------|--------|
| 0 | Check if Studio schema needs sync |
| 1 | Collect info: what to update, new values |
| 2 | Sync schema if needed |
| 3 | Edit files based on user input |
| 4 | Run `npm run test:integration` |
| 5 | Update baselines if needed |
| 6 | Create branch, commit, push, create PR |
| 7 | Tell user PR URL, remind to merge |
| 8 | Watch PR until merged (poll every 1 hour, auto-merge if approved) |
| 9 | Watch Release workflow until complete |
| **Staging** | |
| 10 | Trigger Publish: Staging |
| 11 | Watch Staging workflow, tell user picasso-assets PR URL |
| 12 | Watch picasso-assets PR until merged |
| 13 | Tell user to verify at <https://www.copilot-stg.com/labs> |
| 14 | Ask: "Staging verified. Publish to Production?" |
| **Production** | |
| 15 | Trigger Publish: Production |
| 16 | Watch Production workflow, tell user picasso-assets PR URL |
| 17 | Watch picasso-assets PR until merged |
| 18 | Tell user to verify at <https://www.copilot.microsoft.com/labs> |
| 19 | Remind user to merge studio PR (i18n + fallback) |

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
