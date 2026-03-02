# Research: everything-claude-code

**Date:** 2026-02-27

**Source:** <https://github.com/affaan-m/everything-claude-code>

---

## Overview

Production-ready Claude Code configuration collection by Affaan Mustafa (Anthropic hackathon winner). 53,900+ stars, MIT license. Evolved over 10+ months of intensive daily use with 30 contributors, 14 agents, 56+ skills, 32+ commands.

## Key Findings

- **14 specialized agents** with clear purposes: planner, architect, tdd-guide, code-reviewer, security-reviewer, build-error-resolver, e2e-runner
- **Model selection strategy**: Haiku 4.5 (lightweight agents), Sonnet 4.6 (main development), Opus 4.5 (complex decisions)
- **Rules organized by scope**: `rules/common/` (language-agnostic) + language-specific subdirs
- **Hook stages**: PreToolUse (safety), PostToolUse (formatting), SessionStart (context), SessionEnd (persistence)
- **TDD workflow**: RED → GREEN → REFACTOR with 80% coverage target

## Strengths

- Comprehensive agent specialization with clear tool permissions
- Well-structured rules hierarchy (common → language-specific)
- Hook-driven automation for consistent code quality
- Battle-tested over months of real-world use

## Weaknesses

- Large scope may be overkill for smaller projects
- 6 programming languages create maintenance burden
- Tight coupling to specific model versions

## Takeaways for claude-me

1. **Start with planner and code-reviewer agents** - highest impact specialization
2. **Implement session persistence hooks** - SessionStart/SessionEnd for memory
3. **Use rules/common/ pattern** - language-agnostic rules with overrides
4. **Model selection by task complexity** - not one-size-fits-all
5. **Skill-based knowledge encoding** - reusable workflow expertise
