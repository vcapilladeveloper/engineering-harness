# Android Architecture Conventions

Project-specific conventions on top of `.ai/ARCHITECTURE.md` — not an
Android architecture tutorial. For general Compose/Views/architecture
guidance, prefer Android Studio's own official Google documentation over
anything written here; this file only covers what's specific to how this
harness expects the project to be organized.

## Module boundaries
- `:app` wires modules together and holds no business logic of its own.
- `:feature:*` modules depend on `:core:*` modules, never the reverse. If a
  `:core:*` module needs to know about a specific feature, the abstraction
  is in the wrong place — flag it rather than adding the dependency.
- A new module is always an ADR (`portable-plugin/templates/ADR.md`) — it
  changes `settings.gradle.kts` and the build graph, not just the source
  tree.

## Public API as contract
A module's public (non-`internal`) declarations are its contract with the
rest of the app. Changing one — even a signature tweak — is a cross-module
change: call it out explicitly in the Spec, not just the Technical Plan,
since other modules' owners may need to know.

## When this becomes an ADR
Same bar as the generic `technical-design/SKILL.md`: a new module, a new
cross-module public API, or a changed dependency direction is an ADR. A new
file inside an existing module's existing package structure isn't.
