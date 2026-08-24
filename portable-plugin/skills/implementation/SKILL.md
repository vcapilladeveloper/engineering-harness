---
name: implementation
description: Execute an approved Technical Plan (or small-change Spec) within its authorized scope. Mechanical execution only — no new architectural decisions.
---

# Implementation

Input: an approved Technical Plan or small-change Spec.

- Implement exactly the authorized scope. If the plan turns out not to cover
  something necessary, stop and surface it — don't quietly expand scope
  (`.ai/WORKFLOW.yaml`'s `approvals.scope_deviation`).
- Tests are part of the implementation, not a follow-up step — the change
  isn't done until the agreed tests exist and pass.
- Follow `.ai/CODE_STYLE.md` and the boundaries in `.ai/ARCHITECTURE.md`.
- Git mutations (branch, add, commit, push, etc.) stay human-owned unless
  explicitly requested this session (`.ai/WORKFLOW.yaml`'s `git.mutations`).
- When done, hand off to **verification**.
