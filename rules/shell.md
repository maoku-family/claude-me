# Shell Script Style Rules

Based on [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) and project `.shellcheckrc`.

## When to Use Shell

- Small utilities and wrapper scripts (<100 lines)
- Build automation and CI scripts
- For larger or complex logic, use a structured language (Python, Go, TypeScript)

## Shebang

**ALWAYS use `#!/usr/bin/env bash`:**

```bash
#!/usr/bin/env bash
```

NOT:

```bash
#!/bin/bash          # Less portable
#!/bin/sh            # POSIX only, no Bash features
```

## Strict Mode

**ALWAYS enable strict mode at the top of scripts:**

```bash
#!/usr/bin/env bash
set -euo pipefail
```

| Flag | Meaning |
|------|---------|
| `-e` | Exit immediately on error |
| `-u` | Exit on undefined variable |
| `-o pipefail` | Pipeline fails if any command fails |

## Indentation

- **2 spaces** (never tabs)
- Exception: heredocs require tabs for `<<-`

```bash
# Good
if [[ -f "${file}" ]]; then
  echo "exists"
fi

# Bad - 4 spaces or tabs
if [[ -f "${file}" ]]; then
    echo "exists"
fi
```

## Line Length

- Maximum **80 characters**
- Use backslash for continuation

```bash
# Good - continuation
curl --silent \
  --header "Authorization: Bearer ${token}" \
  --data "${payload}" \
  "${url}"
```

## Variables

### Quoting

**ALWAYS quote variables with braces:**

```bash
# Good
echo "${variable}"
cp "${source}" "${destination}"

# Bad
echo "$variable"    # Missing braces
echo $variable      # Unquoted - dangerous
```

### Naming

| Type | Convention | Example |
|------|------------|---------|
| Local variables | `lowercase_snake_case` | `local file_path=""` |
| Constants | `UPPERCASE_SNAKE_CASE` | `readonly MAX_RETRIES=3` |
| Environment | `UPPERCASE_SNAKE_CASE` | `export PATH="/usr/bin"` |

### Declaration

**Use `local` for function variables:**

```bash
# Good
my_function() {
  local result=""
  result=$(some_command)
  echo "${result}"
}

# Bad - pollutes global scope
my_function() {
  result=$(some_command)
  echo "${result}"
}
```

**Use `readonly` for constants:**

```bash
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_FILE="${SCRIPT_DIR}/config.yaml"
```

## Arrays

**ALWAYS quote array expansions:**

```bash
# Good
files=("file1.txt" "file2.txt" "file with spaces.txt")
for file in "${files[@]}"; do
  echo "${file}"
done

# Bad - breaks on spaces
for file in ${files[@]}; do
  echo "${file}"
done
```

## Conditionals

**ALWAYS use `[[ ]]` instead of `[ ]`:**

```bash
# Good
if [[ -f "${file}" ]]; then
  echo "exists"
fi

if [[ "${string}" == "value" ]]; then
  echo "match"
fi

# Bad - old test syntax
if [ -f "${file}" ]; then
  echo "exists"
fi
```

**Why:** `[[ ]]` avoids pathname expansion and word splitting issues.

## Arithmetic

**Use `(( ))` for arithmetic:**

```bash
# Good
if (( count > 10 )); then
  echo "too many"
fi

(( count++ ))
result=$(( a + b ))

# Bad
if [ "$count" -gt 10 ]; then  # Old style
let count++                    # Deprecated
result=$(expr "$a" + "$b")     # Deprecated
```

## Command Substitution

**Use `$()` instead of backticks:**

```bash
# Good
output=$(command)
nested=$(echo "$(inner_command)")

# Bad - backticks
output=`command`
nested=`echo \`inner_command\``
```

## Control Flow

**Put `; then` and `; do` on the same line:**

```bash
# Good
if [[ -f "${file}" ]]; then
  process "${file}"
fi

for item in "${items[@]}"; do
  echo "${item}"
done

while read -r line; do
  echo "${line}"
done < "${input_file}"

# Bad - newline before then/do
if [[ -f "${file}" ]]
then
  process "${file}"
fi
```

## Case Statements

**ALWAYS include a default case:**

```bash
# Good
case "${option}" in
  start)
    start_service
    ;;
  stop)
    stop_service
    ;;
  *)
    echo "Unknown option: ${option}" >&2
    exit 1
    ;;
esac
```

## Functions

### Naming

**Use `lowercase_snake_case`:**

```bash
# Good
process_file() {
  local file="$1"
  # ...
}

# Bad
ProcessFile() {    # No CamelCase
  # ...
}
```

### Declaration

**Use `name() {` syntax (no `function` keyword):**

```bash
# Good
my_function() {
  # ...
}

# Bad
function my_function {
  # ...
}
```

## Error Handling

**Direct errors to stderr:**

```bash
log_error() {
  echo "[ERROR] $*" >&2
}

log_info() {
  echo "[INFO] $*"
}
```

**Check return values:**

```bash
if ! command_that_might_fail; then
  log_error "Command failed"
  exit 1
fi
```

## Forbidden Patterns

| Pattern | Why | Alternative |
|---------|-----|-------------|
| `eval` | Command injection risk | Use arrays or safer constructs |
| `expr` | Deprecated | `$(( ))` |
| `let` | Deprecated | `(( ))` |
| `$[ ]` | Deprecated | `$(( ))` |
| Pipe to `while` | Subshell scope issues | `while read < <(command)` |
| `which` | Inconsistent behavior | `command -v` |
| SUID/SGID | Security risk | Never on shell scripts |

## Script Template

```bash
#!/usr/bin/env bash
#
# Description: Brief description of what this script does
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

log_info() {
  echo "[INFO] $*"
}

log_error() {
  echo "[ERROR] $*" >&2
}

usage() {
  cat <<EOF
Usage: ${SCRIPT_NAME} [options]

Options:
  -h, --help    Show this help message

EOF
  exit 1
}

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        usage
        ;;
      *)
        log_error "Unknown option: $1"
        usage
        ;;
    esac
  done

  log_info "Starting ${SCRIPT_NAME}..."
  # Main logic here
}

main "$@"
```

## Quick Reference

| Element | Format |
|---------|--------|
| Shebang | `#!/usr/bin/env bash` |
| Strict mode | `set -euo pipefail` |
| Variables | `"${var}"` (quoted with braces) |
| Conditionals | `[[ ]]` (not `[ ]`) |
| Arithmetic | `(( ))` (not `expr` or `let`) |
| Command sub | `$()` (not backticks) |
| Indentation | 2 spaces |
| Line length | 80 characters max |
| Functions | `name() {` (no `function` keyword) |

## Enforcement

These rules are checked by:

- `shellcheck` with `.shellcheckrc` config
- Pre-commit hooks
- CI pipeline
