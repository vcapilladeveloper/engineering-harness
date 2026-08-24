# Android Testing Conventions

Which test type a change needs, not how to write Kotlin/Compose tests — see
Google's official Android testing documentation for that.

## Which type
- Business logic, ViewModels, use cases, repositories (with fakes/mocks) →
  local unit tests (`test/`), fast and JVM-only.
- Real database/DataStore/network integration → instrumented tests
  (`androidTest/`, `connectedAndroidTest`), only where a fake genuinely
  can't stand in.
- Compose UI behavior → Compose UI tests, used sparingly — prefer testing
  the state/logic feeding a composable over exercising the whole UI tree
  when the composable itself is simple.

## What's required (per `verification/SKILL.md`)
- A bug fix needs a regression test that fails before the fix and passes
  after, in the module and test type matching where the bug actually lives
  (see `portable-plugin/templates/SPEC_BUG.md`'s Regression Tests section).
- A new module added per `architecture.md` in this folder needs its own
  test source set unless it's a thin composition layer with no logic of its
  own — note that reasoning explicitly in the Technical Plan rather than
  silently skipping tests for it.

## Fakes over mocks where practical
Prefer a fake implementation of a repository/data source interface over a
mocking framework when the interface is small and stable — it's more
readable and doesn't need re-stubbing every time the interface changes.
