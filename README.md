# Engineering Harness

A **Human-Centered Agentic Engineering Harness** — a portable methodology and toolset for building software with coding agents (Claude Code, Codex, Xcode, others) without delegating the engineer's knowledge, reasoning, or technical ownership.

Two goals at once: productivity **and** long-term technical competence.

## Principles

1. **Human owns intent.** The engineer decides what problem is being solved and when the functional definition is sufficient.
2. **Human owns architectural decisions.** The agent may analyze, challenge, and recommend — never silently introduce structural decisions.
3. **Agent owns mechanical execution after approval.** Once Spec and Technical Plan are approved, the agent may implement the authorized scope.
4. **Tests are part of implementation.** A change isn't done if the agreed tests are missing.
5. **Verification is mandatory.** Build, tests, lint/static analysis where available, and validation against the Spec.
6. **Git mutations are human-owned.** The agent doesn't branch, commit, pull, push, merge, rebase, reset, cherry-pick, or stash without explicit request.
7. **Context must survive sessions.** Durable decisions and short-lived state live in different files.
8. **Cognitive ownership is first-class.** Productivity must never come at the cost of turning the engineer into a spectator of their own code.

## Layout

```
portable-plugin/     methodology + Skills, portable across agents/projects
adapters/             per-agent enforcement (hooks, permissions, rules)
project-template/     drop-in AGENTS.md / CLAUDE.md / .ai/ for a new or existing project
```

## Branches

This repo ships one harness per technology, each as its own branch, so a project only pulls in what applies to it:

| Branch | Technology |
|---|---|
| `main` | Generic — any technology |
| `android` | Android |
| `ios-macos` | iOS / macOS |
| `kmp-cmp` | Kotlin Multiplatform / Compose Multiplatform |

## Setup (this branch: ios-macos)

Drop `project-template/` into your project root (or merge if it already has one), then fill in:

- **`AGENTS.md` / `CLAUDE.md`** — agent entry points. Keep both in sync.
- **`.ai/PROJECT_CONTEXT.md`** — durable facts (stack, modules, dependencies, build, testing, persistence, navigation, constraints). Update only when these actually change.
- **`.ai/ARCHITECTURE.md`** — module/target graph and dependency rules. The agent must not contradict this without your approval.
- **`.ai/CODE_STYLE.md`** — conventions not already enforced by SwiftLint/SwiftFormat.
- **`.ai/HANDOFF.md`** / **`.ai/WORKFLOW.yaml`** — same as the generic branch (short-lived state, and the approval/verification config).
- **`.ai/decisions/`** / **`.ai/specs/`** — ADRs and feature/bug specs.
- **`.ai/features/`** — for multi-Spec features: `<slug>/FEATURE.md` + `DELIVERY_PLAN.md`, with each Change Spec in its own `changes/CS-NNN-<slug>/` folder. Skip this and use `.ai/specs/` directly for anything that's just one Change.
- **`project.yml`** — XcodeGen project spec: bundle id prefix, deployment targets, Swift version/strict concurrency, and the `targets` list. Add a target block per app/framework/test bundle instead of editing the generated `.xcodeproj` by hand; run `xcodegen generate` after any change.
- **`Package.swift`** — SPM dependencies and any local library targets consumed by the app. Add `.package(...)` entries here, then wire them into `project.yml` targets under `dependencies`.
- **`portable-plugin/plugin.json`** — Skills manifest; keep `skills/ios-engineering` enabled.
- **`portable-plugin/mcp.json`** — MCP servers, empty by default.
- **`portable-plugin/templates/`** — SPEC_FEATURE / SPEC_BUG / SPEC_SMALL_CHANGE / TECHNICAL_PLAN / TASKS templates for a single Change Spec, plus FEATURE / DELIVERY_PLAN for multi-Spec features, and ADR. Copy the right one into `.ai/specs/`, `.ai/features/`, or `.ai/decisions/` when starting new work.
- **`portable-plugin/PR_POLICY.md`** — sizing and review rules for PRs produced under this workflow.
- **`portable-plugin/COGNITIVE_ENGINEERING.md`** — the Cognitive Ownership Rule, Cognitive Gates, Explain-back, and Cognitive Debt. Read this before tuning `engineer.cognitive_mode` — it explains what the config actually changes.
- **`adapters/xcode/integration/xcodegen-build-phases.yml`** — a `prebuildScripts` snippet to merge into your target(s): keeps the generated `.xcodeproj` from drifting out of sync with `project.yml`, and runs SwiftLint on every build.
- **`adapters/<agent>/`** — per-agent enforcement; fill in the folder matching your agent.

## Status

Early scaffold. Directory structure and platform branches are stable; template content (SPEC/ADR templates, PR policy, verification checklist, Skills) is still being filled in.
