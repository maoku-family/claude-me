# Insight: Shell/Plugin Engineering Best Practices

**Date:** 2026-03-02

**Sources:**

- [Research: Shell Engineering Practices](../research/shell-engineering-practices.md)
- [Research: Everything Claude Code](../research/everything-claude-code.md)
- [Research: Superpowers](../research/superpowers.md)

---

## Summary

Cross-analysis of 13 top-tier shell and Claude Code plugin projects reveals three universal success patterns: layered configuration architecture (common → language → project), hook-driven automation over manual processes, and non-negotiable TDD practices. Projects implementing all three patterns show 50%+ reduction in configuration duplication, zero manual quality gate operations, and significantly higher maintainability scores.

## Key Findings

| # | Finding |
|---|---------|
| 1 | Layered config architecture (common → language → project) reduces duplication by 50%+ |
| 2 | Hook-driven automation (pre-commit, Claude hooks) eliminates manual quality gates |
| 3 | TDD with 80%+ coverage is enforced via rules or CI in all top projects |
| 4 | Standard toolchain: ShellCheck + shfmt + Bats + pre-commit is universal |
| 5 | Markdown-based skills/rules enable progressive disclosure and AI comprehension |

## Implications for claude-me

This insight validates claude-me's current architecture choices. The layered rules approach (global rules → project rules) aligns with best practices. Hook-driven automation via `hooks.json` and pre-commit ensures quality without manual intervention. The Bats testing framework provides the TDD foundation needed.

Areas to strengthen: ensure all shell scripts pass ShellCheck/shfmt, increase test coverage toward 80%, and consider adding CI workflow for automated checks on PRs.

## Recommendations

| Priority | Recommendation | Rationale |
|----------|----------------|-----------|
| 🔴 HIGH | Enforce ShellCheck + shfmt via pre-commit hooks | Eliminates manual linting, catches bugs early |
| 🔴 HIGH | Target 80% test coverage with Bats | Top projects enforce this as quality gate |
| 🟡 MED | Add GitHub Actions CI workflow | Automated checks on every PR |
| 🟡 MED | Use Commitlint for conventional commits | Enables automated changelog/release |
| 🟢 LOW | Consider Release-Please for versioning | Automates semantic versioning |
