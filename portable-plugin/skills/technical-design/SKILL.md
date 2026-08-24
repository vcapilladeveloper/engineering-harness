---
name: technical-design
description: Turn an approved feature/bug Spec into a reviewable Technical Plan before any code is written. Skip only for small changes.
---

# Technical Design

Input: an approved Spec in `.ai/specs/`. Output: a Technical Plan the human
approves before implementation starts (`.ai/WORKFLOW.yaml`'s
`approvals.technical_plan`).

Copy `portable-plugin/templates/TECHNICAL_PLAN.md` next to the Spec in
`.ai/specs/` and fill it in. Don't skip sections that don't obviously apply —
write "N/A" so a reviewer can tell it was considered, not missed.

Two sections carry the most weight:
- **Current Architecture Impact** — does this touch `.ai/ARCHITECTURE.md`'s
  boundaries? If yes, that's an ADR, and the human decides, not the agent —
  this is the Cognitive Ownership Rule
  (`portable-plugin/COGNITIVE_ENGINEERING.md`), enforced here via
  `.ai/WORKFLOW.yaml`'s `cognitive.architecture_decisions_require_human_ownership`.
- **Testing Strategy** — must actually verify the Spec's acceptance
  criteria, not just "add some tests."

Present the plan and stop — **Gate 2: Technical Plan Approved.** Do not
begin implementation until the human approves it, and do not treat silence
as approval.
