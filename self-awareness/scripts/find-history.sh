#!/usr/bin/env bash
# Read-only: find where this machine keeps agent transcripts and memory.
# Prints locations, file counts, sizes and newest dates. Never prints file contents,
# and never opens auth or credential files.
# Usage: find-history.sh [output.md]   (default: stdout)

set -u
OUT="${1:-/dev/stdout}"

# Common locations. Add your harness's own if it is not listed.
CANDIDATES=(
  "$HOME/.claude/projects:*.jsonl:Claude Code session transcripts (one folder per project)"
  "$HOME/.claude:CLAUDE.md:Claude Code global instructions"
  "$HOME/.claude/projects:MEMORY.md:Claude Code auto-memory indexes"
  "$HOME/.codex/sessions:*.jsonl:Codex session transcripts"
  "$HOME/.codex:AGENTS.md:Codex global instructions"
  "$HOME/.local/share/opencode:*.db:OpenCode session database"
  "$HOME/.gemini:*.json:Gemini CLI history"
  "$HOME/.cursor:*.json:Cursor agent data"
)

newest() {  # newest mtime among matching files, as a date (portable: macOS and Linux)
  python3 - "$1" "$2" <<'PY' 2>/dev/null
import fnmatch, os, sys, time
root, pat = sys.argv[1], sys.argv[2]
skip = ("auth", "cred", "token")
m = 0
for d, _, fs in os.walk(root):
    for f in fs:
        if fnmatch.fnmatch(f, pat) and not any(k in f.lower() for k in skip):
            try: m = max(m, os.stat(os.path.join(d, f)).st_mtime)
            except OSError: pass
print(time.strftime("%Y-%m-%d", time.localtime(m)) if m else "")
PY
}

{
printf '# Transcript and memory locations\n\nGenerated %s. Counts only; no contents read.\n\n' "$(date -u +%Y-%m-%dT%H:%MZ)"
printf '| Location | Pattern | What it is | Files | Size | Newest |\n|---|---|---|---:|---:|---|\n'
for c in "${CANDIDATES[@]}"; do
  dir="${c%%:*}"; rest="${c#*:}"; pat="${rest%%:*}"; what="${rest#*:}"
  [ -d "$dir" ] || continue
  n=$(find "$dir" -type f -name "$pat" ! -iname '*auth*' ! -iname '*cred*' ! -iname '*token*' 2>/dev/null | wc -l | tr -d ' ')
  [ "$n" -gt 0 ] || continue
  size=$(find "$dir" -type f -name "$pat" ! -iname '*auth*' ! -iname '*cred*' ! -iname '*token*' -print0 2>/dev/null | xargs -0 du -ch 2>/dev/null | tail -1 | cut -f1)
  printf '| `%s` | `%s` | %s | %s | %s | %s |\n' "${dir/#$HOME/~}" "$pat" "$what" "$n" "$size" "$(newest "$dir" "$pat")"
done
printf '\nProject-level instruction and memory files in the working folder: '
ls -1 CLAUDE.md AGENTS.md MEMORY.md .claude/CLAUDE.md memory 2>/dev/null | tr '\n' ' '
printf '\n\nNext: follow references/transcript-mining.md. Read only with the human'"'"'s consent.\n'
} > "$OUT"
