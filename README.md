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

## Setup (this branch: android)

Drop `project-template/` into your project root (or merge if it already has one), then fill in:

- **`AGENTS.md` / `CLAUDE.md`** — agent entry points. Keep both in sync.
- **`.ai/PROJECT_CONTEXT.md`** — durable facts (stack, modules, dependencies, build, testing, persistence, navigation, constraints). Update only when these actually change.
- **`.ai/ARCHITECTURE.md`** — module graph and dependency rules (e.g. `:app` → `:feature:*` → `:core:*`). The agent must not contradict this without your approval.
- **`.ai/CODE_STYLE.md`** — conventions not already enforced by ktlint/detekt.
- **`.ai/HANDOFF.md`** / **`.ai/WORKFLOW.yaml`** — same as the generic branch (short-lived state, and the approval/verification config).
- **`.ai/decisions/`** / **`.ai/specs/`** — ADRs and feature/bug specs.
- **`settings.gradle.kts`** — module list and repositories. Set `rootProject.name`, uncomment/add `include(":app")` and each `:feature:*` / `:core:*` module as you create it.
- **`build.gradle.kts`** (root) — top-level plugin versions (AGP, Kotlin). Bump these here, not per-module.
- **`gradle.properties`** — JVM/Gradle daemon flags and AndroidX/Kotlin toggles.
- **`portable-plugin/plugin.json`** — Skills manifest; keep `skills/android-engineering` enabled.
- **`portable-plugin/mcp.json`** — MCP servers, empty by default.
- **`adapters/<agent>/`** — per-agent enforcement; fill in the folder matching your agent.

## Status

Early scaffold — see the linked roadmap for scope and sequencing.
