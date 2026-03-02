# Research: Shell & Claude Code Engineering Practices

**Date:** 2026-03-01

**Source:** Cross-comparison of shell and Claude Code projects

---

## Overview

Analysis of engineering practices across 10+ mature projects: oh-my-zsh (171k stars), nvm (77k stars), asdf (21k stars), ShellCheck (32k stars), bats-core (5.9k stars), everything-claude-code (55k stars), and superpowers (64k stars).

## Key Findings

- **Layered configuration** is optimal: common → language-specific → project-specific
- **Plugin architecture** beats monolithic: oh-my-zsh (300+ plugins), everything-claude-code (56+ skills)
- **Hook-driven automation** is the modern standard (pre-commit, Claude Code hooks)
- **TDD is non-negotiable**: 80% coverage target, RED-GREEN-REFACTOR enforced
- **Documentation as code**: skills/ and CLAUDE.md are executable declarations
- **Semantic versioning + Release-Please** for automated releases
- **POSIX compatibility** enables cross-platform support
- **"Everything is GitHub"**: CI/CD, releases, issues, discussions all in one place

## Strengths

- Shell projects excel at: minimal dependencies, POSIX portability, single-command installation
- Claude Code projects excel at: layered rules, on-demand skill loading, workflow enforcement
- Both share: modular structure, comprehensive testing, automated quality gates

## Weaknesses

- Shell projects: limited testing frameworks (bats vs ShellSpec tradeoffs), no standardized mocking
- Claude Code projects: emerging ecosystem, platform fragmentation (Claude/Cursor/Codex)
- Cross-cutting: documentation maintenance burden, security scanning gaps

## Takeaways for claude-me

1. **Structure**: Use `core/`, `plugins/`, `lib/`, `tests/` layout with <500 lines per plugin
2. **Testing**: Use bats-core for simple scripts, consider ShellSpec for complex logic
3. **Hooks**: Implement PreToolUse, PostToolUse, SessionStart pattern for automation
4. **Linting**: shellcheck + shfmt with EditorConfig (2-space indent, utf-8, LF)
5. **CI/CD**: GitHub Actions with lint → format → test → security pipeline
6. **Skills**: Keep independent, load on-demand, use SKILL.md naming convention
7. **CLAUDE.md**: Keep <100 lines, use pointers to details, avoid code style enforcement (tools handle it)
8. **Hard gates**: Design approval before coding, tests before implementation
9. **Releases**: Semantic versioning with Release-Please automation
10. **Dependencies**: Minimize external deps, prefer POSIX shell, document plugin-specific requirements
