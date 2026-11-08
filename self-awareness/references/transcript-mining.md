# Transcript and memory mining: understanding the human's intent

Goal: learn what the human is really trying to do, from evidence rather than from the current request alone, so
that proposals are motivated by their goals and pains.

## 0. Consent and scope

- Ask before opening transcripts unless the human already asked for this skill to run in full. Say which
  locations you will read.
- Read-only. Never edit, move or delete history files. Skip any file with auth, credential or token in its name.
- Your own harness's memory and instruction files (for example CLAUDE.md, AGENTS.md, memory indexes) are the
  cheapest, highest-signal start. Read them first.

## 1. Locate

Run `scripts/find-history.sh`. It lists transcript and memory locations with file counts, sizes and newest
dates, without reading contents. Transcripts can be gigabytes, so the next steps sample and search.

## 2. Sample recent sessions

Read the human's messages (not your own replies) from the most recent 10 to 30 sessions across projects. Most
transcript formats are JSON lines; filter to user-role messages and skip tool output. Note per session: the
project, what was asked, how it ended, and any correction.

## 3. Search the whole history for signals

Search human messages only. Count hits per theme rather than reading everything.

| Signal | Example search terms |
| --- | --- |
| Corrections and rules | "no,", "don't", "never", "always", "stop", "I told you", "again" |
| Wishes and frustrations | "I wish", "why can't", "it would be great if", "annoying", "every time", "manually" |
| Goals and direction | "goal", "north star", "priority", "this week", "launch", "deadline", "revenue", "users", "members" |
| Repeated manual work | requests that recur across sessions with the same shape (same report, same check, same paste) |
| Approvals and trust | "go", "approved", "ship it", "looks good", and what they refused |
| Unfinished threads | topics that start and never close, "later", "remind me", "after" |

## 4. Write `intent-map.md`

```
## Goals (ranked by evidence)
- <goal>: <evidence count>, e.g. <file or session> (<date>)

## Active projects
## Recurring pain and repeated manual work
## Wishes ("I wish it could...")
## Preferences and rules (how they want to be worked with)
## Unfinished threads
## Motivating factors
What, in their own words, would make the biggest difference to them. This is the input to paradigm shifts.
```

Cite each item by file and date. Quote at most a short phrase. Summarise, do not transcribe.

## Privacy

- Never copy secrets, tokens, passwords, or third parties' personal details into the intent map.
- The intent map is private to the human. Keep it on their machine; never publish it or send it to another
  service without their explicit say-so.
- If you find something sensitive that is not relevant (health, finances, other people's messages), leave it out.
