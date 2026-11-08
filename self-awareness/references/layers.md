# Layers: what to look for and why

Go outside-in when time is short (the app layer and the human matter most), inside-out when the harness is new
to you. For each layer, record powers, half-built things and limits.

## 1. Model and harness

| Look for | Why it matters |
| --- | --- |
| Which harness and model you are, and which other harnesses/models the system can launch | A task stalled on one model's quota may run on another today |
| Tools in your tool list, including deferred ones you must load by name | Deferred tools are invisible until searched for |
| Subagents, workflows, background tasks | Parallelism and keeping context clean |
| Hooks and permission mode | What will be blocked or rewritten before you try it |
| Skills you can load (agent, project, user, plugin) | Each skill is a packaged capability; most go unused |
| MCP servers and their auth state | "Needs authentication" is a half-built capability |
| Context size and compaction behaviour | Whether a long job needs handoff files |

Generic probes: your own tool list and system prompt, `<harness> --version`, `<harness> mcp list`, the harness
settings file (hook and plugin names only).

## 2. Machine

| Look for | Why it matters |
| --- | --- |
| CPU, RAM, free disk | Low disk silently breaks builds, renders and logs |
| Installed CLIs (`command -v`) and which are signed in | A signed-in CLI is an authenticated service |
| Other reachable computers (ssh key names, tailnet peers, mesh) | Heavy or risky work can move off the main box |
| Long-running services (pm2, launchd, docker) | What is already running for the human, and what is dead weight |
| Workspace and project folders | Unfinished projects are latent capabilities |
| Usage and quota per provider | The real budget for any plan |

## 3. Connections

| Look for | Why it matters |
| --- | --- |
| Integration hubs: configured? which accounts? which agents allowed? | Configured-but-empty is a cheap unlock |
| Secret and key NAMES in env and key files | Tells you which APIs are reachable without reading a value |
| Messaging channels (Telegram, Slack, email, SMS) | How you can reach the human, and how they reach you |
| Calendar, docs, notes, CRM | Where the human's real commitments live |

Never print or copy a secret value. If a probe would show one, redact it or skip it.

## 4. App layer (the surface the human sees)

This is where capability turns into the human's experience, so it deserves the most time.

| Look for | Why it matters |
| --- | --- |
| Chat surfaces and what renders in them (cards, choices, forms, charts, approvals) | A card can turn a 20-message thread into one tap |
| Artifacts, files, previews | Reviewable deliverables instead of walls of text |
| Custom pages or dashboards you can build | A live view replaces a recurring status report |
| Tasks, schedules, automations | Work that happens without anyone asking |
| Other agents and sessions | Who else can do work, and who is idle or stopped |
| Knowledge base or search | Whether you can find what the org already knows |
| Goals, approvals, notifications, quiet hours | The rules of engagement with the human |
| Mobile and voice | Where the human actually is during the day |

Read the app's own docs and CLI help, and skim its UI source if available, to list features not yet used.

## 5. The human

| Look for | Why it matters |
| --- | --- |
| North star and goals, with numbers | Meta-moves are ranked against these |
| Current bottleneck and what waits on them | Their attention is usually the scarcest resource |
| Which pending decisions they can actually answer | Unanswerable questions should be reshaped, not re-asked |
| Repeated manual work | Prime targets for schedules, pages and agents |
| Stated rules and approval categories | Hard limits on what any move may do |
| Past plans and their fate | A plan that stalled before will stall again unless its shape changes |
