# Research: Writing a Good CLAUDE.md

**Source:** [HumanLayer Blog](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
**Research Date:** February 28, 2026

## Core Insight

> LLMs are stateless functions with frozen weights that don't learn over time. The only thing that the model knows about your codebase is the tokens you put into it.

CLAUDE.md is the **highest-leverage configuration point** - treat it with care.

## Three Dimensions Framework

| Dimension | Description | Example |
|-----------|-------------|---------|
| **WHAT** | Technical stack and architecture | Apps, packages, monorepo structure |
| **WHY** | Project purpose | What different sections accomplish |
| **HOW** | Practical working instructions | Use `bun` not `node`, how to test |

## Why Claude Ignores CLAUDE.md

Claude Code injects a system reminder:

> "this context may or may not be relevant to your tasks"

**Implication:** Only put **universally applicable** content in CLAUDE.md. Task-specific information gets ignored.

## Best Practices

### 1. Minimize Instructions

- Frontier LLMs reliably follow **150-200 instructions**
- Claude Code's system prompt already contains ~50 instructions
- Keep CLAUDE.md instructions minimal

### 2. Keep It Concise

- Target **< 100 lines** (some teams use < 60 lines)
- Context windows perform better with focused, relevant information

### 3. Progressive Disclosure

Instead of stuffing everything into CLAUDE.md, create separate files:

```text
memory-bank/
├── building_the_project.md
├── running_tests.md
├── code_conventions.md
├── service_architecture.md
└── database_schema.md
```

**Key principle:** "Prefer pointers to copies" - file references don't get outdated.

### 4. Claude Isn't a Linter

- Never use LLMs for code style enforcement
- Use: Biome, ESLint, Prettier, pre-commit hooks

### 5. Avoid Auto-Generation

- Don't use `/init` to auto-generate CLAUDE.md
- A bad line affects every workflow phase
- Manual crafting is worth the effort

## Recommended CLAUDE.md Structure

```markdown
# {project-name}

{One-line description.}

## Core Principles

{3-5 guiding principles for decision-making.}

## Knowledge Locations

{Pointers to project knowledge files.}

## Directory Structure

{Tree view of key directories.}

## Commands

{Essential commands for build, test, run.}
```

## Key Takeaways

1. **WHAT/WHY/HOW** as structuring framework
2. **Universally applicable** content only
3. **Prefer pointers to copies**
4. **150-200 instruction limit** awareness
5. **< 100 lines** target
