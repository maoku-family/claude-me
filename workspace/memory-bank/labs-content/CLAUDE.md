# labs-content

Content management system for Copilot Labs experiment configurations.

## Core Principles

1. **Content Pipeline** - original/ -> generated/ -> dist/ -> publish
2. **Schema Validation** - All configs validated against JSON schema
3. **Baseline Testing** - Integration tests compare against baselines
4. **Localization Flow** - Translations synced from Studio repository

## Directory Structure

```text
content/
├── original/           # Source content (metadata.json + landing-page.md)
├── i18n/               # Localized content synced from Studio
├── generated/          # Built configs (intermediate)
├── dist/               # Release-ready distribution
├── config.schema.json  # JSON schema for validation
└── metadata.schema.json
scripts/                # Build pipeline scripts
tests/integration/      # Baseline-based integration tests
settings.json           # Experiment settings (IDs, enabled flags)
```

## Commands

```bash
# Install
npm install

# Integration tests
npm run test:integration
npm run test:update-integration-baselines  # Update baselines

# E2E tests (Playwright)
npm run test:e2e
npm run test:e2e:headed
```

## Pipeline Scripts

| Script | Purpose |
|--------|---------|
| `sync-translation.js` | Pull translations from Studio |
| `build-configs.js` | Generate configs from source |
| `release.js` | Merge configs into dist/ |
| `config-type-check.js` | Validate against schema |
| `sync-to-studio.js` | Push to Studio repository |
| `sync-to-picasso-assets.js` | Push to Picasso Assets CDN |

## Content Authoring

1. Create `content/original/{experiment}/metadata.json`
2. Create `content/original/{experiment}/landing-page.md`
3. Register in `settings.json`

## Publishing

1. Merge PR -> release branch created
2. Trigger `Publish: Staging` workflow
3. Trigger `Publish: Production` workflow
