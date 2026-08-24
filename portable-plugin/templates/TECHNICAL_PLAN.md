# Technical Plan: <change name>

## Summary
One paragraph: what's being built and why, in implementation terms.

## Current Architecture Impact
Does this touch `.ai/ARCHITECTURE.md`'s boundaries? If yes, this needs an
ADR — see `portable-plugin/COGNITIVE_ENGINEERING.md`'s Cognitive Ownership
Rule.

## Proposed Design
The chosen approach, in enough detail to review — not full code.

## Components / Modules
Which modules/files are involved, and why each needs to change.

## Data Flow
How data moves through the change, if non-trivial.

## Public APIs / Protocols
New or changed public contracts.

## Concurrency
Actor isolation, threading, async boundaries touched. Flag anything
non-obvious explicitly.

## Persistence
Schema, migration, or storage impact, if any.

## Error Handling
How failures are surfaced and recovered from.

## Testing Strategy
What will verify the Spec's acceptance criteria (unit/integration/UI as
applicable).

## Files Expected to Change
- ...

## Alternatives Considered
Options evaluated and why they were rejected — brief, only if the choice
wasn't obvious.

## Trade-offs
What this approach gives up in exchange for what it gains.

## Risks
What could go wrong, and how likely/severe.

## Migration / Rollout
Feature flags, staged rollout, backwards compatibility — if applicable.

## Open Technical Decisions
Anything still unresolved that needs a decision before or during
implementation.
