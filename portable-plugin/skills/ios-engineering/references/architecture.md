# iOS/macOS Architecture Conventions

Project-specific conventions on top of `.ai/ARCHITECTURE.md` — not a Swift
architecture tutorial. For general SwiftUI/UIKit/architecture guidance,
prefer Xcode's own official Apple documentation over anything written here;
this file only covers what's specific to how this harness expects the
project to be organized.

## Target boundaries
- One target per deployable/testable unit (app, framework, extension, test
  bundle) — not per feature. Feature boundaries inside a target are folders,
  not separate targets, unless there's a real reason to build/ship them
  independently (e.g. a widget extension, a shared framework consumed by
  both iOS and macOS targets).
- A new target is always an ADR (`portable-plugin/templates/ADR.md`) — it
  changes the build graph and CI, not just the source tree.

## Dependency direction
- Feature code depends on shared/core code, never the reverse. If a "core"
  module needs to know about a specific feature, that's a sign the
  abstraction is in the wrong place — flag it rather than adding the
  dependency.
- SPM package dependencies are structural: adding one is a Technical Plan
  decision, not a local implementation detail, because it changes what the
  whole target links against.

## When this becomes an ADR
Use the same bar as the generic `technical-design/SKILL.md`: if it changes
`.ai/ARCHITECTURE.md`'s boundaries (a new target, a new package dependency,
a new cross-target protocol), it's an ADR. If it's a new file inside an
existing target's existing folder structure, it isn't.
