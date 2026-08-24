# Pilot Log: <project name>

Informal tracking for the v0.5 Pilot phase (spec §32) — no tooling needed,
just enough discipline to notice patterns. Copy this into the pilot
project's `.ai/` folder and add one row per Change run through the harness.

## Delivery metrics
Track per Change:

| Change | Cognitive Mode | Build/test pass rate | Rework after approval | Scope deviations | Bugs found in verification | Cycle time |
|---|---|---|---|---|---|---|
| CS-001 ... | pair | | | | | |

## Cognitive metrics
Review periodically (weekly, or at the end of the pilot), not per Change:

- **Decisions made explicitly by the human** — roughly how many, and did
  the mode match what actually happened?
- **Changes the human can explain when done** — could you walk someone
  through what shipped without looking at the code?
- **Unjustified abstractions** — how often did something get built that
  couldn't be defended in a review?
- **Recurring Knowledge Check themes** — the same gap showing up more than
  once is worth addressing directly, not just re-explaining each time.
- **Needing AI to reconstruct recently-written code** — a strong signal of
  Cognitive Debt (`portable-plugin/COGNITIVE_ENGINEERING.md`) if this
  happens often.
- **Periodic ability to implement small pieces without the agent** — still
  possible, or has it atrophied?

These aren't meant to gamify learning — they exist to catch growing
cognitive dependence early, not to score performance.

## Anti-dependency practice (optional, spec §33)
Especially in `learning` mode, or periodically regardless of mode:
- implement a small piece manually before comparing with the agent;
- reconstruct a recent solution from memory;
- attempt a bug fix without agent-generated code first;
- explain a piece of architecture out loud without opening the repo;
- ask the agent for a code review without letting it apply the fix.

## Findings to feed back
What friction, redundant rules, or missing templates did this Change
surface? File these as issues against the harness repo, or note them here
and batch them at the end of the pilot.

- ...
