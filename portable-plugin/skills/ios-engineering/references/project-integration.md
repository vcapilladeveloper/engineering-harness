# Xcode Project Integration

How this harness's config files fit together for an XcodeGen-based project —
see the branch README for what each file is, this is about the workflow
connecting them.

## Adding a target
1. Add the target block to `project.yml` (per `architecture.md` in this
   folder, this is an ADR).
2. Run `xcodegen generate`, or rely on
   `adapters/xcode/integration/xcodegen-build-phases.yml` if it's merged
   into the project — it regenerates automatically when `project.yml`
   changes.
3. Add the matching test target if the new target has logic of its own
   (see `testing.md` in this folder).

## Adding a dependency
1. Add it to `Package.swift`.
2. Wire it into the consuming target's `dependencies` in `project.yml`.
3. Regenerate (see above). Note the new dependency in the Technical Plan —
   it's a structural decision, not a local one (`architecture.md`).

## Keeping the generated project honest
`.xcodeproj` is gitignored and fully generated from `project.yml` — never
hand-edit it. If Xcode-side changes (build settings, scheme tweaks) are
needed, express them in `project.yml` and regenerate, so they survive a
clean checkout.
