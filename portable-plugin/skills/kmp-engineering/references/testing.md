# KMP/CMP Testing Conventions

Which test source set a change needs, not how to write Kotlin tests — see
Kotlin's official multiplatform testing documentation for that.

## Which source set
- Shared business logic in `commonMain` → `commonTest`, runs on every
  target — this is the default and should cover the large majority of
  logic, since most logic should live in `commonMain` in the first place
  (see `architecture.md` in this folder).
- Platform-specific `actual` implementations → the matching platform test
  source set (`androidUnitTest`, `iosTest`, etc.), only for the platform
  logic that can't be tested from `commonTest`.
- Compose Multiplatform UI → platform UI tests, used sparingly and only on
  the targets that actually ship that UI — don't require UI tests on every
  target for a single shared composable unless its rendering genuinely
  differs per platform.

## What's required (per `verification/SKILL.md`)
- A bug fix needs a regression test in `commonTest` if the bug is in shared
  logic, or the matching platform test source set if it's a platform-only
  bug (see `portable-plugin/templates/SPEC_BUG.md`'s Regression Tests
  section).
- A new `expect`/`actual` pair (per `architecture.md`) needs test coverage
  on every platform that has an `actual` implementation — a shared
  `commonTest` alone doesn't verify platform-specific behavior.

## Running the full matrix
`./gradlew build` alone doesn't guarantee every target was tested — use
`:shared:allTests` or the per-target test tasks so a change verified only
on the developer's own platform doesn't silently ship broken on another.
