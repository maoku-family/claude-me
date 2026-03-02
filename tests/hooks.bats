#!/usr/bin/env bats
# Hook Tests for claude-me
# Run with: bats tests/hooks.bats

CLAUDE_ME_ROOT="${HOME}/Repos/claude-me"
HOOK_SCRIPT="${CLAUDE_ME_ROOT}/hooks/load-project-context.sh"

# =============================================================================
# Test: Project Context Loading
# =============================================================================

@test "hook loads project context when in workspace/repos/{project}/" {
  local test_project="bats-test-project"

  # Setup
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  cat > "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}/CLAUDE.md" << 'EOF'
# Test Project

Secret phrase: TEST_PROJECT_LOADED_SUCCESS
EOF

  cd "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  git init -q 2> /dev/null || true

  # Run hook
  run bash -c "cd '${CLAUDE_ME_ROOT}/workspace/repos/${test_project}' && '${HOOK_SCRIPT}'"

  # Cleanup
  rm -rf "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  rm -rf "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  # Assertions
  [ "$status" -eq 0 ]
  echo "$output" | jq -e '.hookSpecificOutput.additionalContext' > /dev/null
  echo "$output" | jq -r '.hookSpecificOutput.additionalContext' | grep -q "TEST_PROJECT_LOADED_SUCCESS"
}

# =============================================================================
# Test: Feature Context Loading
# =============================================================================

@test "hook loads feature context when on feature/* branch" {
  local test_project="bats-test-feature"

  # Setup
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}/features/auth"

  cat > "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}/CLAUDE.md" << 'EOF'
# Test Project

Secret phrase: PROJECT_CONTEXT_LOADED
EOF

  cat > "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}/features/auth/spec.md" << 'EOF'
# Auth Feature

Secret phrase: FEATURE_AUTH_LOADED
EOF

  cd "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  git init -q 2> /dev/null || true
  git checkout -b feature/auth 2> /dev/null || true

  # Run hook
  run bash -c "cd '${CLAUDE_ME_ROOT}/workspace/repos/${test_project}' && '${HOOK_SCRIPT}'"

  # Cleanup
  rm -rf "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  rm -rf "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  # Assertions
  [ "$status" -eq 0 ]

  local content
  content=$(echo "$output" | jq -r '.hookSpecificOutput.additionalContext')

  echo "$content" | grep -q "PROJECT_CONTEXT_LOADED"
  echo "$content" | grep -q "FEATURE_AUTH_LOADED"
}

# =============================================================================
# Test: No Output Outside Workspace
# =============================================================================

@test "hook outputs nothing when not in workspace/repos/" {
  # Run hook from claude-me root (not in workspace/repos/)
  run bash -c "cd '${CLAUDE_ME_ROOT}' && '${HOOK_SCRIPT}'"

  # Assertions
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

# =============================================================================
# Test: No Output When Project Has No CLAUDE.md
# =============================================================================

@test "hook outputs nothing when project has no CLAUDE.md" {
  local test_project="bats-test-no-claude-md"

  # Setup - create project WITHOUT CLAUDE.md
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  mkdir -p "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"
  # Note: NOT creating CLAUDE.md

  cd "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  git init -q 2> /dev/null || true

  # Run hook
  run bash -c "cd '${CLAUDE_ME_ROOT}/workspace/repos/${test_project}' && '${HOOK_SCRIPT}'"

  # Cleanup
  rm -rf "${CLAUDE_ME_ROOT}/workspace/repos/${test_project}"
  rm -rf "${CLAUDE_ME_ROOT}/workspace/memory-bank/${test_project}"

  # Assertions
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}
