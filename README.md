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

## How It Works

Every non-trivial change follows the same workflow
(`portable-plugin/skills/software-change/SKILL.md`), gated by human approval
at each step:

1. **Feature-sized work only** — refine the product intent, write
   `FEATURE.md` + `DELIVERY_PLAN.md`, and get **Gate 0: Delivery Slicing
   Approved** before starting the first Change Spec.
2. Write a Spec (`SPEC_FEATURE.md` / `SPEC_BUG.md` / `SPEC_SMALL_CHANGE.md`)
   — **Gate 1: SPEC Approved**.
3. Design the solution as a `TECHNICAL_PLAN.md` — **Gate 2: Technical Plan
   Approved**, immediately followed by the **PR Planning Gate**
   (`portable-plugin/PR_POLICY.md`): is this reviewable as one PR, or does
   it need to split?
4. **Gate 3: Implementation Authorized** — the agent states the expected
   files and confirms no Git mutations, then asks to proceed.
5. Implement and test the approved scope. The **Scope Deviation Gate** can
   fire at any point here — a new dependency, an architecture change, a
   public API change — the agent stops and asks rather than expanding
   scope silently.
6. Verify: build, tests, lint, and the Spec's acceptance criteria.
7. Context Handoff: update `.ai/HANDOFF.md`, write an ADR if a durable
   decision was made.

How much the agent asks versus proposes at each gate is set by
**Cognitive Mode** (`portable-plugin/COGNITIVE_ENGINEERING.md`), one of
three settings in `.ai/WORKFLOW.yaml`:

| Mode | Roughly | Agent behavior |
|---|---|---|
| `learning` | 80% human / 20% agent | Asks first, challenges assumptions, checks understanding often. |
| `pair` (default) | 50/50 | Proposes alternatives and trade-offs; human decides on anything significant. |
| `delivery` | 20% human / 80% agent | Runs with minimal interruption — but Spec/Plan/Scope-Deviation/Git approval stay protected regardless of mode. |

Every gate leaves a durable file behind, not just a conversation — that's
what makes the workflow resumable across sessions and reviewable by someone
who wasn't there when the decision was made.
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

## Setup (this branch: kmp-cmp)

See [INSTALL.md](INSTALL.md) for how to load this harness's Skills and
adapters into your agent. The rest of this section covers which config
files to fill in once it's installed.

Drop `project-template/` into your project root (or merge if it already has one), then fill in:

- **`AGENTS.md` / `CLAUDE.md`** — agent entry points. Keep both in sync.
- **`.ai/PROJECT_CONTEXT.md`** — durable facts (stack, modules, dependencies, build, testing, persistence, navigation, constraints). Update only when these actually change.
- **`.ai/ARCHITECTURE.md`** — source-set graph (what's `commonMain` vs `expect`/`actual` per target) and dependency rules. The agent must not contradict this without your approval.
- **`.ai/CODE_STYLE.md`** — conventions not already enforced by ktlint/detekt.
- **`.ai/HANDOFF.md`** / **`.ai/WORKFLOW.yaml`** — same as the generic branch (short-lived state, and the approval/verification config).
- **`.ai/decisions/`** / **`.ai/specs/`** — ADRs and feature/bug specs, including `expect`/`actual` boundary decisions.
- **`.ai/features/`** — for multi-Spec features: `<slug>/FEATURE.md` + `DELIVERY_PLAN.md`, with each Change Spec in its own `changes/CS-NNN-<slug>/` folder. Skip this and use `.ai/specs/` directly for anything that's just one Change.
- **`settings.gradle.kts`** — module list. `:shared` holds the KMP/CMP code; add `:androidApp` / `:desktopApp` (and wire an iOS app via Xcode/SPM consuming the shared framework) as targets go live.
- **`build.gradle.kts`** (root) — top-level plugin versions (AGP, Kotlin, Compose Multiplatform). Bump here, not per-module.
- **`shared/build.gradle.kts`** — the KMP module: declared targets (`androidTarget`, `iosX64`/`iosArm64`/`iosSimulatorArm64`, `jvm("desktop")`) and source sets. Add a target by declaring it here, then add its `xxxMain`/`xxxTest` source set; put code in `commonMain` unless a platform genuinely needs an `expect`/`actual` split.
- **`gradle.properties`** — JVM/Gradle daemon flags, AndroidX toggle, and `kotlin.mpp.enableCInteropCommonization` for iOS interop.
- **`portable-plugin/plugin.json`** — Skills manifest; keep `skills/kmp-engineering` enabled.
- **`portable-plugin/mcp.json`** — MCP servers, empty by default.
- **`portable-plugin/templates/`** — SPEC_FEATURE / SPEC_BUG / SPEC_SMALL_CHANGE / TECHNICAL_PLAN / TASKS templates for a single Change Spec, plus FEATURE / DELIVERY_PLAN for multi-Spec features, and ADR. Copy the right one into `.ai/specs/`, `.ai/features/`, or `.ai/decisions/` when starting new work.
- **`portable-plugin/PR_POLICY.md`** — sizing and review rules for PRs produced under this workflow.
- **`portable-plugin/COGNITIVE_ENGINEERING.md`** — the Cognitive Ownership Rule, Cognitive Gates, Explain-back, and Cognitive Debt. Read this before tuning `engineer.cognitive_mode` — it explains what the config actually changes.
- **`portable-plugin/templates/PILOT_LOG.md`** — informal per-Change delivery/cognitive metrics tracking. Only needed if you're piloting the harness on a project rather than just using it.
- **`adapters/<agent>/`** — per-agent enforcement; fill in the folder matching your agent.

## Status

Early scaffold. Directory structure and platform branches are stable; template content (SPEC/ADR templates, PR policy, verification checklist, Skills) is still being filled in.
