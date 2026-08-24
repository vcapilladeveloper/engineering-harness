---
name: context-handoff
description: Close out a change or session — update HANDOFF.md, record durable decisions as ADRs, and leave the next session (human or agent) with accurate state.
---

# Context Handoff

Run this at the end of a change, or when a session is ending mid-work.

1. Update `.ai/HANDOFF.md`: what's in progress, the next step, open
   questions. Overwrite the old content — this file is short-lived state, not
   a log.
2. If the change made a durable architectural decision, write it as
   `.ai/decisions/ADR-<NNNN>-<slug>.md` using `portable-plugin/templates/ADR.md`.
   Don't retroactively write ADRs for decisions that were never really
   decisions.
3. If `.ai/PROJECT_CONTEXT.md` facts changed (new dependency, new module,
   changed build command), update it now — don't leave it stale for the next
   session to discover.
4. Move the Spec in `.ai/specs/` to reflect its final state (done, or a note
   on why it's paused).
