#!/usr/bin/env bash
#
# Description: Check if plan.md was created, remind to run /plan before execution
#

set -euo pipefail

INPUT=$(cat)
FILE=$(echo "${INPUT}" | jq -r '.tool_input.file_path // .tool_input.path // ""')

# Check if this is a plan.md file being created/modified
if [[ "${FILE}" == *"plan.md" && "${FILE}" != *"task_plan.md" ]]; then
  # Output reminder as additionalContext
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "PostToolUse",
      "additionalContext": "Plan file created/updated. REMINDER: When user approves this plan, run /plan to initialize planning-with-files (task_plan.md, findings.md, progress.md) before starting execution."
    }
  }'
fi

exit 0
