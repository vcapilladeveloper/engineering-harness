# Bug Fix Spec: <name>

## Observed Behaviour

## Expected Behaviour

## Reproduction Steps

## Evidence
Logs / screenshots / failing test / stack trace.

## Root Cause
Known / hypothesis / unresolved. Don't confuse symptom with root cause — if
it isn't proven yet, label it as a hypothesis and keep investigating before
shipping a structural fix.

## Fix Scope
Confirm the fix addresses the root cause for every caller, not just the
reported path.

## Regression Risk

## Acceptance Criteria
- [ ] Bug no longer reproduces via the steps above.

## Regression Tests
A test that fails before the fix, reproduces the broken behavior, passes
after the fix, and stays as a regression guard. For bugs that can't be
captured in a unit test, document the alternative verification method
explicitly.
