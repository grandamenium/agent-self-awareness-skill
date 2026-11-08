# Self-Awareness Skill for AI Agents

Your agent doesn't know what it can actually do. It works from a generic self-model: "I'm a helpful assistant
with some tools." Meanwhile the machine it runs on may have five agent harnesses, signed-in CLIs, other
computers on the network, scheduled jobs, a dashboard it can build pages in, and an integration hub with
nothing connected. Or one model may be out of quota while another sits unused.

This skill makes the agent look before it plans. It takes stock of its own setup, researches online how the
most advanced users push that exact setup, studies its own past conversations to understand what you are
really trying to do, and then proposes ranked paradigm shifts: changes to how it works with you, including new
skills, hooks, integrations and interfaces it could give itself.

It only proposes. It never acts on a move without your approval.

---

## What it does

1. **Inventory (read-only).** A script probes each layer and writes the raw evidence to a file in seconds:
   - **Model and harness:** which harnesses and models can run, MCP servers and their auth state, hooks, skills.
   - **Machine:** CPU, RAM, free disk, installed CLIs, packages and apps, other reachable computers, long-running services.
   - **Connections:** messaging channels, GitHub and API keys **by name only**. Secret values are never printed.
   - **Interface:** how you actually work with the agent (terminal, desktop app, chat, phone, cards, pages).
2. **Frontier research.** For the harness, model, interface, machine, network and notable tools, it reads the
   docs and changelogs, then GitHub, marketplaces, blogs and threads from people on the cutting edge. It notes
   features you have but don't use, and how others modify the same harness.
3. **Transcript and memory mining (with your consent).** A second script finds where your agent history lives
   (counts only). The agent then samples recent sessions and searches for goals, corrections, wishes and
   repeated manual work, and writes a private intent map that stays on your machine.
4. **Capability map.** For each layer: what the agent can do, what's **half-built** (installed but not
   connected, built but switched off), and what limits it, plus the frontier findings that apply. Every claim is
   tagged verified, inferred or unknown, and every number gets a date.
5. **Paradigm shifts.** About 20 candidates from 19 patterns (teach yourself once, guard yourself, wire in what is
   installed, meet the human where they are, work while they're away, and more). Every move needs three legs:
   something you want (intent), something the agent can do here (capability) and evidence it works (frontier).
   Scored on impact, effort, your attention and risk. You get the top 10.
6. **Propose, don't do.** A plan with the top 10 and "first 3 this week", each with the approval it needs.

## The finding that matters most: contradictions

The most useful output is often not a capability but a place where two sources disagree. For example:

- a usage meter says a model is out of quota, yet the agent is running on it;
- a status list says a process is stopped, yet its scheduled jobs ran an hour ago;
- a goals document lists decisions waiting on you, yet your approval queue is empty.

The skill tells the agent to write both readings down rather than quietly pick one.

## Install

The skill is the `self-awareness/` folder. Copy it wherever your agent harness loads skills from, for example
in Claude Code:

```bash
git clone https://github.com/grandamenium/agent-self-awareness-skill
cp -R agent-self-awareness-skill/self-awareness ~/.claude/skills/
```

Then ask your agent something like:

- "What could you do here that we're not using?"
- "Take stock of yourself and plan everything."
- "We just updated. What does this unlock?"
- "Upgrade yourself. Research what's possible and tell me what you'd change."

The skill also triggers at the start of big tasks, when the agent is stuck, and in weekly reviews.

## Files

| File | What it is |
|---|---|
| `self-awareness/SKILL.md` | The frame, the four-step procedure, triggers and outputs |
| `self-awareness/scripts/find-history.sh` | Read-only locator for transcripts and memory: counts and dates, never contents |
| `self-awareness/scripts/inventory.sh` | Read-only probe (bash; tested on macOS, untested on Linux). Missing tools are recorded as absent |
| `self-awareness/references/layers.md` | What to look for in each layer, and why |
| `self-awareness/references/frontier-research.md` | How to research the setup online: sources, what to look for, safety |
| `self-awareness/references/transcript-mining.md` | How to study past sessions for intent, with consent and privacy rules |
| `self-awareness/references/meta-moves.md` | The 19 meta-move and paradigm-shift patterns, scoring, write-up format |
| `self-awareness/references/capability-map-template.md` | Output template |

## Safety

- The inventory is read-only: listings, `--help`, status commands and file reads. No installs, config edits, messages or restarts.
- Secret values are never read. Keys show up by name, emails and URLs in probe output are redacted, and tokens are filtered.
- Web pages are treated as data: the agent never follows instructions found online and installs nothing during research. It doesn't put your private details into search queries.
- It reads transcripts only with your consent, skips auth and credential files, and keeps the intent map on your machine.
- Look over the scripts before running them, as you would any script.

## Limits

- Tested on macOS with Claude Code. Other harnesses and Linux should work but are less tested.
- Frontier research and transcript mining are guided steps the agent does with its own tools, not scripts. Their quality depends on the web and search tools it has.
- Large histories (gigabytes) are sampled and searched, not read in full.
- It proposes moves. Whether a move is worth doing is still your call.
