---
name: software-change
description: Entry point for any non-trivial code change in a harness-managed project. Routes feature-sized requests through a Delivery Plan first, then every Change Spec through technical-design, implementation, verification and context-handoff in order.
---

# Software Change Workflow

This is the workflow `AGENTS.md`/`CLAUDE.md` point every change at. Don't skip
steps because the change "feels small" — the small-change template exists for
that case, it isn't a bypass of the workflow.

## Step 0 — Feature or single Change?

If the request is one bounded, independently reviewable increment, skip to
Step 1. If it spans several independent behaviors (e.g. "add authentication"
rather than "add login validation"), it's a Feature:

1. Refine at the product level and write `.ai/features/<slug>/FEATURE.md`
   (`portable-plugin/templates/FEATURE.md`).
2. Propose a vertical-slice breakdown into small, coherent Change Specs
   (CS-001, CS-002, ...) and write `.ai/features/<slug>/DELIVERY_PLAN.md`
   (`portable-plugin/templates/DELIVERY_PLAN.md`). Prefer vertical slices
   that each deliver verifiable behavior over horizontal layers (all
   models, then all view models, then all UI) — see
   `portable-plugin/PR_POLICY.md`.
3. Get human approval on the slicing before starting the first Change Spec —
   **Gate 0: Delivery Slicing Approved**.
4. Run each Change Spec through Steps 1-7 below, inside
   `.ai/features/<slug>/changes/CS-NNN-<slug>/`.

## Steps 1-7 — Per Change Spec

1. **Classify the change** using the templates in `portable-plugin/templates/`:
   - New user-facing capability → `SPEC_FEATURE.md`
   - Something is broken → `SPEC_BUG.md`
   - Single-file/function, no architectural decision → `SPEC_SMALL_CHANGE.md`
2. Write the Spec into `.ai/specs/` (or the Change Spec's folder under
   `.ai/features/`, if Step 0 applied). Get human approval before
   continuing — **Gate 1: SPEC Approved**
   (`.ai/WORKFLOW.yaml`'s `approvals.spec`). Depending on the active
   `cognitive_mode`, this approval can itself be a Cognitive Gate (e.g.
   asking the human to propose a solution first) — see
   `portable-plugin/COGNITIVE_ENGINEERING.md`.
3. Hand off to the **technical-design** Skill for anything beyond a small
   change — it ends with **Gate 2: Technical Plan Approved**, immediately
   followed by the **PR Planning Gate** (`portable-plugin/PR_POLICY.md`):
   confirm the resulting PR will be reviewable, or split the Change Spec if
   not.
4. Hand off to **implementation** once the Technical Plan (or the
   small-change spec itself) is approved — it opens with
   **Gate 3: Implementation Authorized** before any code changes, and
   watches for the **Scope Deviation Gate** throughout.
5. Hand off to **verification** before considering the change done.
6. Hand off to **context-handoff** to close out — update `.ai/HANDOFF.md`,
   write an ADR if a durable decision was made.
7. Follow `portable-plugin/PR_POLICY.md` when opening the PR.

Never silently widen scope mid-change — that's what the Scope Deviation Gate
(see `implementation/SKILL.md`) is for. If the work reveals a bigger
problem, stop and write a new Spec for it instead of folding it into the
current one.
