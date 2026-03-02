#!/usr/bin/env bats
# Skill Tests for claude-me
# Run with: bats tests/skills.bats
# Note: These tests require claude CLI and may take longer to run

CLAUDE_ME_ROOT="${HOME}/Repos/claude-me"

# =============================================================================
# Test: CLAUDE.md Location Convention
# =============================================================================

@test "skill creates CLAUDE.md in workspace/memory-bank/ not workspace/repos/" {
  local test_project="bats-test-skill-location"

  # Setup
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  cd "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  git init -q 2> /dev/null || true
  echo '{"name": "test-app", "description": "Test"}' > package.json

  # Run claude to create CLAUDE.md
  CLAUDECODE='' claude -p "创建 CLAUDE.md，技术栈 TypeScript，原则随便" --allowedTools "Write,Read,Bash,Glob" > /dev/null 2>&1

  # Check results before cleanup
  local in_memory_bank=false
  local in_repos=false

  [ -f "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}/CLAUDE.md" ] && in_memory_bank=true
  [ -f "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}/CLAUDE.md" ] && in_repos=true

  # Cleanup
  rm -rf "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  rm -rf "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  # Assertions
  [ "$in_memory_bank" = true ]
  [ "$in_repos" = false ]
}
