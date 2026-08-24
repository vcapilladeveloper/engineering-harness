# Delivery Plan: <feature name>

Connects `FEATURE.md` to its Change Specs and expected PRs. Doesn't repeat
technical detail — that belongs in each Change Spec's `TECHNICAL_PLAN.md`.

## Strategy
Vertical-slice reasoning: why this breakdown, and why this order. Prefer
slices that each deliver verifiable behavior over horizontal layers (all
models, then all view models, then all UI) — see `portable-plugin/PR_POLICY.md`.

## Change Specs

### CS-001 — <name>
- Delivers:
- Depends on:
- Expected PR:
- Status: not started | in progress | in review | merged

### CS-002 — <name>
- Delivers:
- Depends on:
- Expected PR:
- Status:

## Dependency Graph
How the Change Specs above depend on each other, if not already obvious
from the list.

## Rollout / Feature Flag Strategy
How partially-shipped Change Specs stay safe to merge before the full
feature is live.

## Integration Risks
What could break when these Change Specs land together.

## Definition of Feature Done
The condition under which the Feature (not just one Change Spec) is
considered complete — usually "all Change Specs above meet their acceptance
criteria and the Product Acceptance Criteria in `FEATURE.md` are met."
