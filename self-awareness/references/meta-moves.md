# Meta-moves: patterns and ranking

A meta-move changes the shape of a problem using the system's own functionality. Test: after the move, is the
problem smaller, cheaper or self-running, or did we just do one more unit of it?

## Patterns to try against every goal

1. **Recurring to scheduled.** Something the human or an agent does every day becomes a schedule with a
   review gate.
2. **Report to live view.** A status message sent over and over becomes a page or dashboard they open when they want.
3. **Judgement call to answerable choice.** A question they cannot answer becomes 2 to 4 concrete options with a
   recommended default, or a reversible trial with a date. Re-asking an unanswerable question costs trust.
4. **Review to gate.** Reading every output becomes a check the system runs, with the human seeing only failures.
5. **Built but off to switched on.** Find engines, integrations and agents that are finished but idle; the unlock
   is usually one credential or one "yes".
6. **Blocked resource to alternate route.** Quota, disk, a stopped agent or an unconnected app: route around it
   with another harness, computer or channel.
7. **Measure the unmeasured lever.** If the biggest input to the goal is not tracked, the first move is
   instrumentation, not effort.
8. **Check the arithmetic.** If the plan cannot reach the goal with the numbers on disk, the move is reframing the
   plan, not executing it harder.
9. **One artifact, many uses.** Work done for one business (a factory, a skill, a case study) becomes content,
   product or proof for another.
10. **Capability to product.** Something the fleet does well for the human may be what the human sells.
11. **Fewer, sharper agents.** Stopped, duplicated or stale agents and sessions cost attention; consolidating is a move.
12. **Memory and handoff.** Decisions that keep getting re-asked need one written source of truth that every
    agent reads.

## Paradigm-shift patterns (changing how the agent works with the human)

13. **Teach yourself once.** Something the human explains again and again becomes a skill, a memory entry or an
    instruction file, so it is never explained again.
14. **Guard yourself.** A mistake the human keeps correcting becomes a hook or check that runs before the action.
15. **Wire in what is installed.** A CLI, app, key or MCP server on the machine that no workflow uses becomes an
    integration (inventory shows it, research shows how others use it).
16. **Meet the human where they are.** Work they wait for at a desk reaches them on their phone, by voice, as a
    one-tap card, or as a live page, through the interface they already use.
17. **Work while they are away.** Recurring or long work moves to scheduled or background runs that report back,
    on this machine or another one.
18. **Extend your reach.** A second computer, a cloud box or a browser session becomes part of what you can do,
    with the same safety rules.
19. **Borrow from the frontier.** A pattern advanced users run with this exact harness (from `frontier.md`)
    adapted to this human's goals.

## Scoring

Score each candidate 1 to 5:

- **Impact:** how far it moves the north star or removes a recurring cost.
- **Effort:** agent effort plus elapsed time (5 = largest).
- **Human cost:** minutes of the human's attention, and whether it needs a judgement or just a "yes" (5 = most).
- **Risk:** what breaks or ships wrongly if it goes badly (5 = worst).

Rank by `impact * 2 - effort - human cost - risk`, then sanity-check the order by hand. The formula is a
tiebreaker, not an oracle. It ignores time: move a time-boxed opportunity (a quota window, a deadline tonight)
up, and a slow-compounding one down, and say why in one line.

## Write-up per move

```
### N. <name>
- What: one or two sentences.
- Why it changes the problem: the shape change, not the speed-up.
- Intent leg: what in the intent map motivates it (cite file and date).
- Capability leg: what on the capability map makes it possible (cite).
- Frontier leg: the research finding that shows it works (link).
- Effort: S/M/L with a rough agent-hours figure.  Risk: low/med/high, and what could go wrong.
- Approval needed: the exact category and who gives it.
```
