---
name: ios-engineering
description: iOS/macOS-specific conventions and checks layered on top of the generic software-change workflow — target boundaries, XcodeGen/SPM config, and platform testing.
---

# iOS/macOS Engineering

Applies on top of `software-change` / `technical-design` / `implementation` /
`verification` — this Skill only adds what's Apple-platform-specific.

## Technical Design additions
- State which target(s) in `project.yml` a change touches. A new target
  (framework, extension, test bundle) is an ADR, not a silent edit.
- New SPM dependency → add it to `Package.swift`, then wire it into the
  target's `dependencies` in `project.yml`. Note it in the Technical Plan.
- Flag anything touching actor isolation or `Sendable` conformance
  explicitly — that's architectural under Swift's strict concurrency, not
  mechanical.

## Implementation notes
- Run `xcodegen generate` after any `project.yml` change before building —
  don't hand-edit the generated `.xcodeproj`.
- Respect the module/target boundaries recorded in `.ai/ARCHITECTURE.md`.

## Verification additions
- Build via `xcodebuild` (or the scheme used in CI) for the affected
  target(s), on top of the generic build check.
- Run the test bundle covering the change; add one if none exists yet.
- SwiftLint/SwiftFormat if configured — run it, don't skip it.

## Config files this touches
See the branch README for `project.yml` / `Package.swift` setup.
