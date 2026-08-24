# Xcode Adapter

Xcode has no agent to constrain, so this adapter is different in kind from
`claude-code` and `codex` — it's about making the harness's project-side
rules visible and enforced inside Xcode itself, on top of what Xcode/Apple's
own tooling already knows (spec §21: don't duplicate Apple's official
guidance here).

- **`integration/xcodegen-build-phases.yml`** — a `prebuildScripts` snippet
  to merge into the relevant target(s) in the project's real `project.yml`.
  Keeps the generated `.xcodeproj` (gitignored, never committed — see
  `.gitignore`) from silently drifting out of sync with `project.yml`, and
  runs SwiftLint as part of every build so `ios-engineering/SKILL.md`'s
  verification step isn't something you only remember to do by hand.
