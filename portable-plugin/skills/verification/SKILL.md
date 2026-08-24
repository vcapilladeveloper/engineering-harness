---
name: verification
description: Mandatory pre-done checklist for every change — build, tests, lint/static analysis where available, and acceptance-criteria validation against the Spec.
---

# Verification Checklist

Required before any change is considered done (`.ai/WORKFLOW.yaml`'s
`verification` block):

- [ ] **Build** succeeds from a clean state.
- [ ] **Tests** — the ones agreed in the Technical Plan/Spec pass, including
      new regression tests for bug fixes.
- [ ] **Lint / static analysis** — run when the project has it configured;
      don't add tooling just to satisfy this checkbox.
- [ ] **Acceptance criteria** — re-read the Spec and confirm each checkbox is
      actually true, not just plausible.
- [ ] **Scope check** — the diff matches the approved Technical Plan;
      anything extra is called out, not silently included.

Report results honestly, including what wasn't run and why. "The agent said
it passed" is not verification — the human confirms the commands were
actually run for anything that ends up in the PR description.

For changes with real cognitive weight, verification is also a good moment
for an Explain-back check (`portable-plugin/COGNITIVE_ENGINEERING.md`) —
confirm the human can restate why the fix/design works, not just that the
tests are green.
