---
name: software-change
description: Entry point for any non-trivial code change in a harness-managed project. Routes to a Spec, then technical-design, implementation, verification and context-handoff in order.
---

# Software Change Workflow

This is the workflow `AGENTS.md`/`CLAUDE.md` point every change at. Don't skip
steps because the change "feels small" — the small-change template exists for
that case, it isn't a bypass of the workflow.

1. **Classify the change** using the templates in `portable-plugin/templates/`:
   - New user-facing capability → `SPEC_FEATURE.md`
   - Something is broken → `SPEC_BUG.md`
   - Single-file/function, no architectural decision → `SPEC_SMALL_CHANGE.md`
2. Write the Spec into `.ai/specs/`. Get human approval before continuing —
   see `.ai/WORKFLOW.yaml`'s `approvals.spec`.
3. Hand off to the **technical-design** Skill for anything beyond a small
   change.
4. Hand off to **implementation** once the Technical Plan (or the
   small-change spec itself) is approved.
5. Hand off to **verification** before considering the change done.
6. Hand off to **context-handoff** to close out — update `.ai/HANDOFF.md`,
   write an ADR if a durable decision was made.
7. Follow `portable-plugin/PR_POLICY.md` when opening the PR.

Never silently widen scope mid-change. If the work reveals a bigger problem,
stop and write a new Spec for it instead of folding it into the current one.
