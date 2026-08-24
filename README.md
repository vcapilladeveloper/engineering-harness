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

## Setup (this branch: generic)

Drop `project-template/` into your project root (or merge its contents if the project already has an `.ai/` folder), then fill in:

- **`AGENTS.md` / `CLAUDE.md`** — agent entry points. Keep both in sync; they point at the same `.ai/` files. Edit only if your agent reads a different bootstrap file.
- **`.ai/PROJECT_CONTEXT.md`** — durable facts (stack, modules, dependencies, build, testing, persistence, navigation, constraints). Update only when these actually change.
- **`.ai/ARCHITECTURE.md`** — layers, dependency rules, boundaries, conventions. The agent must not contradict this without your approval.
- **`.ai/CODE_STYLE.md`** — conventions not already enforced by a linter/formatter config.
- **`.ai/HANDOFF.md`** — short-lived state for resuming work. Overwrite freely.
- **`.ai/WORKFLOW.yaml`** — the harness config: engineer seniority/cognitive mode, which approvals are required, which git mutations are forbidden without explicit request, and verification requirements. Tune `engineer.seniority` and `engineer.cognitive_mode` to how much oversight you want; leave `git.mutations: forbidden_without_explicit_request` unless you want the agent branching/committing on its own.
- **`.ai/decisions/`** — one file per ADR (Architecture Decision Record). Empty until a durable decision is made.
- **`.ai/specs/`** — one file per feature/bug spec before implementation starts.
- **`portable-plugin/plugin.json`** — the Skills manifest. Add/remove entries under `skills` to change which Skills load for this project.
- **`portable-plugin/mcp.json`** — MCP servers available to the harness. Empty by default; add servers your workflow needs.
- **`portable-plugin/templates/`** — SPEC_FEATURE / SPEC_BUG / SPEC_SMALL_CHANGE / TECHNICAL_PLAN / ADR templates. Copy the right one into `.ai/specs/` or `.ai/decisions/` when starting new work.
- **`portable-plugin/PR_POLICY.md`** — sizing and review rules for PRs produced under this workflow.
- **`portable-plugin/COGNITIVE_ENGINEERING.md`** — the Cognitive Ownership Rule, Cognitive Gates, Explain-back, and Cognitive Debt. Read this before tuning `engineer.cognitive_mode` — it explains what the config actually changes.
- **`adapters/<agent>/`** — per-agent enforcement (hooks, permissions, rules), already populated for `claude-code` and `codex`. Merge the relevant one into your project; leave the other agent's folder alone if unused.

## Status

Early scaffold. Directory structure and platform branches are stable; template content (SPEC/ADR templates, PR policy, verification checklist, Skills) is still being filled in.
