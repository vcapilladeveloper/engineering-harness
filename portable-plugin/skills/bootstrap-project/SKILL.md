---
name: bootstrap-project
description: Use when setting up the Engineering Harness in a new or existing project — drops in project-template, fills PROJECT_CONTEXT.md, and wires the right adapter.
---

# Bootstrap Project

1. Copy `project-template/` into the target project root (merge `.ai/` if one
   already exists).
2. Fill `.ai/PROJECT_CONTEXT.md` with the real stack, modules, build, and test
   commands. Don't leave placeholders — a wrong or missing fact here misleads
   every later change.
3. Fill `.ai/ARCHITECTURE.md` with the actual current layering/boundaries,
   not an aspirational one.
4. Pick the matching branch of this harness (`main` generic, `android`,
   `ios-macos`, `kmp-cmp`) for the platform-specific config skeleton, and
   merge its `project-template/` extras (Gradle/Xcode/KMP files) if starting
   from scratch.
5. Enable the matching adapter under `adapters/<agent>/` for whichever coding
   agent(s) the project uses.
6. Set `.ai/WORKFLOW.yaml`'s `engineer.seniority` and `engineer.cognitive_mode`
   to match how much oversight is wanted.
7. Leave `.ai/decisions/` and `.ai/specs/` empty — they fill up as real work
   happens, not at bootstrap time.

Bootstrapping is a one-time setup pass. Once done, use `software-change` for
every subsequent change.
