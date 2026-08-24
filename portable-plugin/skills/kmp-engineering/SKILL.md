---
name: kmp-engineering
description: Kotlin Multiplatform/Compose Multiplatform-specific conventions layered on top of the generic software-change workflow — source-set placement, expect/actual boundaries, and per-target verification.
---

# KMP/CMP Engineering

Applies on top of `software-change` / `technical-design` / `implementation` /
`verification` — this Skill only adds what's multiplatform-specific.

## Technical Design additions
- Default new code to `commonMain`. An `expect`/`actual` split is an
  architectural decision — state the platform reason (an API only available
  on one target) in the Technical Plan, and write an ADR if it establishes a
  new abstraction other code will follow.
- State which targets in `shared/build.gradle.kts` are affected
  (`androidTarget`, `iosX64`/`iosArm64`/`iosSimulatorArm64`, `jvm("desktop")`).
  A new target is an ADR.

## Implementation notes
- Keep platform-specific code behind the smallest possible `actual`
  implementation — logic belongs in `commonMain`, not duplicated per target.
- Respect the source-set dependency graph recorded in `.ai/ARCHITECTURE.md`.

## Verification additions
- `./gradlew build` plus `:shared:allTests` (or the per-target test tasks),
  so the change is actually verified on every affected target, not just the
  one you developed on.
- For UI changes, check Compose Multiplatform rendering on each target that
  ships UI, not just Android.

## Config files this touches
See the branch README for `settings.gradle.kts` / `shared/build.gradle.kts`
/ `gradle.properties` setup.
