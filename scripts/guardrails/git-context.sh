#!/bin/bash
# Helper: emit a one-line git summary from a JSON payload that includes `cwd`.
# Outputs one-line git summary to stdout. Silent no-op outside git repos.

set -euo pipefail

# Consume stdin JSON — we only need `cwd`.
EVENT=$(cat)
CWD=$(echo "$EVENT" | python3 -c "import json,sys; print(json.load(sys.stdin).get('cwd',''))" 2>/dev/null || true)
[ -z "$CWD" ] && exit 0

cd "$CWD" 2>/dev/null || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
LAST=$(git log -1 --format='"%s" (%cr)' 2>/dev/null || echo "no commits")

echo "[git] branch: ${BRANCH} | staged:${STAGED} modified:${MODIFIED} untracked:${UNTRACKED} | last: ${LAST}"
