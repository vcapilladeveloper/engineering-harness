# Reviewable PR Policy

A PR must be reviewable by a human in one sitting. Size and scope rules
exist to keep that true even when an agent can generate a large diff
quickly.

> A change isn't well designed for a team if it technically works but no
> teammate can review it with confidence in a reasonable amount of time.

## Reviewability check (before proposing implementation)

Before implementation starts, the agent should be able to answer yes to
most of these — if not, that's a signal to split (see below), not a reason
to skip the check:

- Does this have a single purpose?
- Can a reviewer understand the goal without knowing the whole Feature?
- Does the diff mix refactor + feature + unrelated formatting?
- Can the scope be reduced without creating artificial architecture just to
  make it smaller?
- Are there preparatory changes that deserve their own PR?
- Do the tests help the reviewer understand the behavior, not just pad
  coverage?
- Can this integrate safely even if the full Feature isn't active yet?

## Signals a Change Spec should be split

Not a rigid line-count rule — a set of signals to evaluate explicitly. When
several of these are true, split before implementing:

- multiple independent functional behaviors;
- multiple loosely related subsystems;
- a large refactor mixed with new functionality;
- a migration mixed with a feature in the same diff;
- too many simultaneous architectural decisions;
- the reviewer would need to hold too much context in their head at once;
- the change needs an unusually long PR description to explain;
- tests for independent areas are changing at the same time;
- several conceptually independent commits would each be reviewable on
  their own.

As a heuristic (not policy): once a PR starts touching dozens of files or
hundreds of lines of new logic, evaluate explicitly whether it should
split. **The reviewer's cognitive load is what matters, not the exact line
count.**

## Slicing strategy

Preferred order when splitting a Feature:
1. **Vertical functional slices** — preferred. Each slice delivers
   verifiable behavior end-to-end (UI + logic + data), not one
   architectural layer at a time.
2. Small, reusable preparatory changes, only when actually necessary.
3. Independent, safe migrations.
4. Refactors, only when they clearly reduce the risk of the next change.

Avoid building "architecture for the architecture's sake" just to get
smaller PRs.

### Worked example: Login/Signup

```
Feature: Authentication

PR 1 / CS-001  Minimal authentication contracts + test doubles
  Reason: small, stable prerequisite.

PR 2 / CS-002  Login end-to-end happy path
  UI, ViewModel/presentation, use case/domain, repository integration, tests.

PR 3 / CS-003  Login validation + error states
  Invalid credentials, connectivity, loading/retry, accessibility, tests.

PR 4 / CS-004  Signup end-to-end
PR 5 / CS-005  Session persistence + restore
PR 6 / CS-006  Logout
```

If CS-001 turns out to introduce only speculative abstractions with no
independent value, fold it into CS-002 instead of keeping it separate.

**Small PRs are a means, not the goal.** Aim for each PR being coherent,
verifiable, integrable, and easy to review — not for fragmenting the design
artificially to hit a size target.

## PR Planning Gate

Before implementation, the agent presents a PR plan — or a recommendation
to split, with reasons — and the human approves it, right after
`technical-design`'s Gate 2 and before `implementation`'s Gate 3.

If reviewable as one PR:
```
PR PLAN

Change Spec: CS-002 Login
Suggested delivery: 1 PR

Why this is reviewable:
- single behaviour: email/password login
- 6 expected production files
- 4 test files
- no unrelated refactor
- no schema migration
- no public API break

Dependencies:
- CS-001 merged first

Out of scope:
- signup
- password recovery
- session restoration
```

If it should split:
```
I recommend splitting this Change Spec before implementation.

Reason:
- introduces session persistence
- modifies authentication UI
- adds credential migration
- changes public Auth API

Suggested split:
CS-002A Login flow
CS-002B Session persistence
CS-002C Credential migration
```

The human always approves the split — the agent proposes, it doesn't decide
unilaterally.

## Why this matters cognitively

An oversized PR creates two kinds of debt:
- **Reviewer Cognitive Load** — too many simultaneous decisions for
  whoever reviews it.
- **Author Cognitive Debt** — the author may have delegated a set of
  changes so large they no longer mentally control the whole change (see
  `portable-plugin/COGNITIVE_ENGINEERING.md`).

Optimize for all three at once: small enough to understand, large enough to
be coherent, complete enough to verify.

How much the agent drives slicing depends on `cognitive_mode`:
- **Learning** — the agent asks first: how would you divide this? What
  increment delivers independent value first? Which part carries the most
  review risk? Then critiques and improves the user's answer.
- **Pair** — agent and user propose the Delivery Plan together; the agent
  presents alternatives and trade-offs.
- **Delivery** — the agent proposes the Feature Spec + Delivery Plan +
  Change Specs directly and asks for one approval on the slicing before
  continuing. Even in Delivery mode, the agent must not default a whole
  Feature into a single PR just because it's technically able to implement
  it all at once.

## Required in every PR description
- Link to the Spec (and Technical Plan, if one exists).
- What changed and why, in the engineer's own words — not just the agent's
  summary.
- Test plan: what was run, and what wasn't (and why).
- Any deliberate scope deviation from the approved Spec/Plan, with the
  reason.

## Review expectations
- The human author must be able to explain any line an agent generated, on
  request.
- No PR merges solely because "the agent said tests pass" — the human
  confirms verification actually ran (see the `verification` Skill).
- Architectural decisions inside the diff must trace back to an ADR or the
  Spec's approved Technical Plan, not be introduced silently.
- Generated/vendored files don't count toward the reviewability signals
  above, but must be called out explicitly in the PR description.
