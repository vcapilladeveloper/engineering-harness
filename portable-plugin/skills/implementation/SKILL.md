---
name: implementation
description: Execute an approved Technical Plan (or small-change Spec) within its authorized scope. Mechanical execution only — no new architectural decisions.
---

# Implementation

Input: an approved Technical Plan or small-change Spec.

- For non-trivial plans, break the work into
  `portable-plugin/templates/TASKS.md` next to the Spec before starting —
  optional for small changes. Work the tasks in order; don't skip straight
  to writing code for the whole plan at once.
- Implement exactly the authorized scope. Local, reversible decisions clearly
  inside the approved plan don't need a check-in; anything that changes
  scope, guarantees, architecture, or a public contract does — stop and
  surface it (`.ai/WORKFLOW.yaml`'s `approvals.scope_deviation`, and the
  Cognitive Ownership Rule in `portable-plugin/COGNITIVE_ENGINEERING.md`).
- Tests are part of the implementation, not a follow-up step — the change
  isn't done until the agreed tests exist and pass.
- Follow `.ai/CODE_STYLE.md` and the boundaries in `.ai/ARCHITECTURE.md`.
- Git mutations (branch, add, commit, push, etc.) stay human-owned unless
  explicitly requested this session (`.ai/WORKFLOW.yaml`'s `git.mutations`).
- When done, hand off to **verification**.
