# Reviewable PR Policy

A PR must be reviewable by a human in one sitting. Size and scope rules exist
to keep that true even when an agent can generate a large diff quickly.

## Sizing
- One PR = one Spec (feature, bug, or small change). Don't bundle unrelated
  specs into one PR.
- Prefer under ~400 changed lines. Split larger work into a sequence of PRs
  described by the Technical Plan, rather than one large diff.
- Generated/vendored files don't count toward the limit but must be called
  out explicitly in the PR description.

## Required in every PR description
- Link to the Spec (and Technical Plan, if one exists).
- What changed and why, in the engineer's own words — not just the agent's
  summary.
- Test plan: what was run, and what wasn't (and why).
- Any deliberate scope deviation from the approved Spec/Plan, with the reason.

## Review expectations
- The human author must be able to explain any line an agent generated, on
  request.
- No PR merges solely because "the agent said tests pass" — the human
  confirms verification actually ran (see the `verification` Skill).
- Architectural decisions inside the diff must trace back to an ADR or the
  Spec's approved Technical Plan, not be introduced silently.
