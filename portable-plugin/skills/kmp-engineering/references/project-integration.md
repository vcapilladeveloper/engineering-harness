# KMP Gradle Project Integration

How this harness's config files fit together for this project — see the
branch README for what each file is, this is about the workflow connecting
them.

## Adding a target
1. Declare it in `shared/build.gradle.kts`'s `kotlin { }` block (per
   `architecture.md` in this folder, a new target is an ADR).
2. Add the matching `xxxMain`/`xxxTest` source set.
3. Register any new consuming module (`:androidApp`, `:desktopApp`) in
   `settings.gradle.kts`.

## Adding a dependency
1. Add it to the relevant source set's dependency block in
   `shared/build.gradle.kts` — `commonMain` if every target needs it, the
   platform source set if only one does.
2. Note the new dependency in the Technical Plan — it's a structural
   decision, not a local one (`architecture.md`).

## Root-level changes
Plugin version bumps (AGP, Kotlin, Compose Multiplatform) belong in the
root `build.gradle.kts`, not `shared/build.gradle.kts` — keeps versions in
one place instead of drifting between modules as more are added.

## iOS consumption
The shared module ships to iOS as a generated framework — changes to its
public API are a contract change for the iOS app the same way a public API
change would be for any other consumer; treat it with the same weight as a
public API change on the `ios-macos` branch's `ios-engineering` Skill.
