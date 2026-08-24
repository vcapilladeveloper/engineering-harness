---
name: android-engineering
description: Android-specific conventions and checks layered on top of the generic software-change workflow — module boundaries, Gradle config, and platform testing.
---

# Android Engineering

Applies on top of `software-change` / `technical-design` / `implementation` /
`verification` — this Skill only adds what's Android-specific.

## Technical Design additions
- State which Gradle module(s) a change touches and why (`:app`,
  `:feature:*`, `:core:*`). A new module is an ADR, not a silent addition to
  `settings.gradle.kts`.
- Note any new dependency and its version, added via the version catalog if
  the project has one — don't hardcode versions inline in a module's
  `build.gradle.kts` if a catalog exists.

## Implementation notes
- Respect the module dependency direction recorded in `.ai/ARCHITECTURE.md`
  (typically `:feature:*` depends on `:core:*`, never the reverse).
- A module's public API is the contract with the rest of the app — changing
  one is a cross-module change, call it out in the Spec.

## Verification additions
- `./gradlew build` and the relevant module's `test` / `connectedAndroidTest`
  tasks, on top of the generic build/test check.
- Lint: `./gradlew lint` (or ktlint/detekt if configured) — run it, don't
  skip it because "it's probably fine."

## Config files this touches
See the branch README for `settings.gradle.kts` / `build.gradle.kts` /
`gradle.properties` setup.

## References
Read on demand, not upfront — each covers one topic in more depth than
belongs here:
- `references/architecture.md` — module boundaries, dependency direction,
  when a change needs an ADR.
- `references/concurrency.md` — which coroutines/Flow decisions are
  architectural (stop and ask) vs local (implement freely).
- `references/testing.md` — which test type a change needs.
- `references/project-integration.md` — the actual steps for adding a
  module or dependency through Gradle.
