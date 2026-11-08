#!/usr/bin/env bash
# Read-only capability inventory for the self-awareness skill.
# Usage: inventory.sh [output.md]   (default: stdout)
# Writes raw evidence, layer by layer. It never prints secret values: env and
# key files are reported by NAME only, and URLs and emails in output are redacted.
# Every probe is optional: a missing tool is skipped, not an error.

set -u
OUT="${1:-/dev/stdout}"
LIMIT="${INVENTORY_LIMIT:-25}"   # max lines kept per probe

have() { command -v "$1" >/dev/null 2>&1; }

# Run a command with a time limit (macOS has no `timeout`), trim, redact.
probe() {
  local label="$1"; shift
  printf '\n### %s\n\n```text\n' "$label"
  perl -e 'alarm shift; exec @ARGV' 25 "$@" 2>&1 \
    | sed -E 's#https?://[^ )"]+#<url>#g; s#[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,}#<email>#g' \
    | head -n "$LIMIT" | awk 1   # awk 1 restores a final newline so the fence closes
  printf '```\n'
}

section() { printf '\n## %s\n' "$1"; }

{
printf '# Capability inventory (raw)\n\nGenerated %s. Read-only probes; values of secrets are never printed.\n' \
  "$(date -u +%Y-%m-%dT%H:%MZ)"

section "1. Model and harness"
printf '\nHarness env hints (names only): '
env | cut -d= -f1 | grep -E '^(CLAUDE|CODEX|OPENCODE|GEMINI|CURSOR|ANTHROPIC_MODEL|OPENAI_MODEL)' | sort | tr '\n' ' '
printf '\n'
have claude && probe "Claude Code version" claude --version
have claude && probe "MCP servers (Claude Code)" claude mcp list
[ -f "$HOME/.claude/settings.json" ] && probe "Claude Code hooks, plugins, permission mode" python3 -c '
import json,os
d=json.load(open(os.path.expanduser("~/.claude/settings.json")))
print("hooks:", {k: len(v) for k, v in d.get("hooks", {}).items()})
print("permission mode:", d.get("permissions", {}).get("defaultMode"))
print("plugins:", ", ".join(d.get("enabledPlugins", {}).keys()))'
have codex && probe "Codex version" codex --version
probe "Skills visible (project, user)" sh -c 'for d in .claude/skills "$HOME/.claude/skills" "$HOME/.codex/skills"; do [ -d "$d" ] && echo "$d: $(ls -1 "$d" | tr "\n" " ")"; done'

section "2. Machine"
probe "Hardware and OS" sh -c 'uname -mrs; sysctl -n hw.model hw.ncpu 2>/dev/null || nproc 2>/dev/null; echo "RAM GB: $(( $(sysctl -n hw.memsize 2>/dev/null || echo 0) / 1073741824 ))"'
probe "Disk (root)" df -h /
probe "CLIs present" sh -c 'for c in git gh node python3 uv pm2 docker ffmpeg jq claude codex opencode gemini cursor playwright cloudflared wrangler vercel supabase aws gcloud tailscale; do command -v $c >/dev/null && printf "%s " $c; done; echo'
INVENTORY_LIMIT_SAVE="$LIMIT"; LIMIT=60   # package lists are the input to frontier research, keep more
have brew && probe "Homebrew packages (names)" sh -c 'brew leaves 2>/dev/null | tr "\n" " "; echo; echo "casks: $(brew list --cask 2>/dev/null | tr "\n" " ")"'
have npm && probe "Global npm packages (names)" sh -c 'npm ls -g --depth=0 --parseable 2>/dev/null | sed "1d; s#.*/node_modules/##" | tr "\n" " "'
have pipx && probe "pipx packages (names)" sh -c 'pipx list --short 2>/dev/null | awk "{print \$1}" | tr "\n" " "'
have uv && probe "uv tools (names)" sh -c 'uv tool list 2>/dev/null | grep -v "^-" | awk "{print \$1}" | tr "\n" " "'
[ -d /Applications ] && probe "Desktop apps (names)" sh -c 'ls /Applications | sed "s/\.app$//" | tr "\n" ","'
LIMIT="$INVENTORY_LIMIT_SAVE"
probe "Other computers (ssh key and Host NAMES only)" sh -c 'ls "$HOME/.ssh" 2>/dev/null | grep -vE "known_hosts|config|authorized" | grep -v "\.pub$"; grep -E "^Host " "$HOME/.ssh/config" 2>/dev/null'
if have tailscale; then TS=tailscale; elif [ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]; then TS=/Applications/Tailscale.app/Contents/MacOS/Tailscale; else TS=""; fi
[ -n "$TS" ] && probe "Tailnet peers" sh -c "$TS status 2>/dev/null | awk '/offline/{off++; next} {on=on \$2 \" \"} END{print \"online:\", on; print \"offline count:\", off+0}'"
have pm2 && probe "Long-running processes (pm2)" sh -c 'pm2 jlist 2>/dev/null | python3 -c "import json,sys; ps=json.load(sys.stdin); print(\"online:\", \" \".join(p[\"name\"] for p in ps if p[\"pm2_env\"][\"status\"]==\"online\")); print(\"not online:\", sum(p[\"pm2_env\"][\"status\"]!=\"online\" for p in ps))"'
probe "Scheduled jobs (counts only)" sh -c 'echo "crontab lines: $(crontab -l 2>/dev/null | grep -cvE "^\s*(#|$)")"; [ -d "$HOME/Library/LaunchAgents" ] && echo "user LaunchAgents: $(ls "$HOME/Library/LaunchAgents" | wc -l | tr -d " ")"'

section "3. Connections"
probe "Secret NAMES in env (values never printed)" sh -c 'env | cut -d= -f1 | grep -E "KEY|TOKEN|SECRET" | sort'
have gh && probe "GitHub auth (account and scopes, no token)" sh -c 'gh auth status 2>&1 | grep -E "Logged in|scopes"'

section "4. App layer"
printf '\nNo generic probe can see the app the human uses. Inventory it by hand (references/layers.md, section 4):\n'
printf 'read the app'"'"'s CLI --help, its docs, and the skills that describe its features (cards, pages, tasks, schedules, agents).\n'

section "5. The human"
probe "Goal and plan files near the working folder (names only)" sh -c 'ls -1 2>/dev/null | grep -iE "goal|plan|roadmap|okr|todo|board|status|readme" | head -20'
printf '\nRead the goals and the documents behind them by hand (references/layers.md, section 5).\n'
printf '\n_End of raw inventory. Turn this into the capability map (references/capability-map-template.md)._\n'
} > "$OUT"
