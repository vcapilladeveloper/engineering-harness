---
name: technical-design
description: Turn an approved feature/bug Spec into a reviewable Technical Plan before any code is written. Skip only for small changes.
---

# Technical Design

Input: an approved Spec in `.ai/specs/`. Output: a Technical Plan the human
approves before implementation starts (`.ai/WORKFLOW.yaml`'s
`approvals.technical_plan`).

A Technical Plan states:
- **Approach** — the chosen design, in enough detail to review, not full
  code.
- **Files/modules touched** — and why each one needs to change.
- **Alternatives considered** — briefly, if the choice wasn't obvious.
- **Architectural impact** — does this touch `.ai/ARCHITECTURE.md`'s
  boundaries? If yes, that's an ADR, and the human decides, not the agent
  (see `.ai/WORKFLOW.yaml`'s
  `cognitive.architecture_decisions_require_human_ownership`).
- **Test plan** — what will verify the acceptance criteria.

Present the plan and stop. Do not begin implementation until the human
approves it, and do not treat silence as approval.
