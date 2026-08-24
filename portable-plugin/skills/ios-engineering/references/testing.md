# iOS/macOS Testing Conventions

Which test bundle a change needs, not how to write Swift tests — see Apple's
Swift Testing / XCTest documentation for that.

## Which bundle
- Business logic, models, view models → unit test target.
- Cross-module integration (repository + persistence, networking + parsing)
  → integration tests in the same or a dedicated integration test target,
  if the project has one.
- User-visible flows spanning multiple screens → UI test target, used
  sparingly — prefer unit/integration coverage of the logic underneath a UI
  flow over driving the whole flow through the UI.

## What's required (per `verification/SKILL.md`)
- A bug fix needs a regression test that fails before the fix and passes
  after, in the bundle matching where the bug actually lives (see
  `portable-plugin/templates/SPEC_BUG.md`'s Regression Tests section).
- A new target added per `architecture.md` in this folder needs its own
  test target unless it's a thin composition layer with no logic of its
  own — note that reasoning explicitly in the Technical Plan rather than
  silently skipping tests for it.

## Swift Testing vs XCTest
Use whichever the project already uses (`.ai/PROJECT_CONTEXT.md`). Don't mix
frameworks within one test target without a Technical Plan decision to do
so — that's a project-wide convention change, not a local one.
