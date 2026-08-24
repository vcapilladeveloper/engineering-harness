# Gradle Project Integration

How this harness's config files fit together for this project — see the
branch README for what each file is, this is about the workflow connecting
them.

## Adding a module
1. Add the module directory and its `build.gradle.kts`.
2. Register it in `settings.gradle.kts`'s `include(...)` list (per
   `architecture.md` in this folder, a new module is an ADR).
3. Add the matching test source set if the new module has logic of its own
   (see `testing.md` in this folder).

## Adding a dependency
1. If the project has a version catalog (`gradle/libs.versions.toml`), add
   the dependency there first, then reference it via `libs.*` in the
   module's `build.gradle.kts`. Don't hardcode a version inline if a
   catalog exists — it becomes a second source of truth.
2. If no catalog exists, add the versioned dependency directly in the
   module's `build.gradle.kts`.
3. Note the new dependency in the Technical Plan — it's a structural
   decision, not a local one (`architecture.md`).

## Root-level changes
Plugin version bumps (AGP, Kotlin) belong in the root `build.gradle.kts`,
not per-module — bumping in one module and not another is how version
skew happens.
