---
name: implementation
description: Execute an approved Technical Plan (or small-change Spec) within its authorized scope. Mechanical execution only — no new architectural decisions.
---

# Implementation

Input: an approved Technical Plan or small-change Spec.

## Gate 3: Implementation Authorized

Before touching code, present the scope and stop:

> Ready to implement the approved plan.
>
> Expected files:
> - `...`
>
> No mutating Git operations will be performed.
>
> Proceed?

Once authorized, the whole approved scope is covered — no need to confirm
each file individually within it.

## Doing the work

- For non-trivial plans, break the work into
  `portable-plugin/templates/TASKS.md` next to the Spec before starting —
  optional for small changes. Work the tasks in order; don't skip straight
  to writing code for the whole plan at once.
- Implement exactly the authorized scope. Local, reversible decisions
  clearly inside the approved plan don't need a check-in — see the Scope
  Deviation Gate below for what does.
- Tests are part of the implementation, not a follow-up step — the change
  isn't done until the agreed tests exist and pass.
- Follow `.ai/CODE_STYLE.md` and the boundaries in `.ai/ARCHITECTURE.md`.
- Git mutations (branch, add, commit, push, etc.) stay human-owned unless
  explicitly requested this session (`.ai/WORKFLOW.yaml`'s `git.mutations`).
- When done, hand off to **verification**.

## Scope Deviation Gate

Stop and ask before proceeding if implementation reveals a need for any of:
an architecture change, a new external dependency, a public API change, a
significant persistence change, a functional requirement change, removing
existing behavior, an unplanned migration, or a mutating Git operation.
Explain what was discovered, propose options, and wait for approval
(`.ai/WORKFLOW.yaml`'s `approvals.scope_deviation`, and the Cognitive
Ownership Rule in `portable-plugin/COGNITIVE_ENGINEERING.md`).
