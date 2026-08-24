# Installation

How to get this harness's Skills, adapters, and project template actually
loaded by your coding agent. For which config files to fill in once it's
installed, see this branch's README Setup section.

## 1. Pick your branch
`main` (generic), `android`, `ios-macos`, or `kmp-cmp` — see the README's
Branches table. Each ships the same portable methodology plus a
platform-specific `project-template/` config skeleton.

## 2. Drop in the project template
Copy this branch's `project-template/` into your project root (merge `.ai/`
if one already exists). See the README's Setup section for what to fill in.

## 3. Install the Skills

### Claude Code
Copy `portable-plugin/skills/` into your project's Claude Code skills
location (or point Claude Code at this repo's `portable-plugin/` directly,
if your installed version supports loading skills from an external path —
check your version's plugin/skills documentation, this mechanism has
changed across releases). Merge
`adapters/claude-code/permissions/settings.json` into your project's
`.claude/settings.json`.

### Codex
Codex reads `AGENTS.md` automatically once it's in your project root (step
2 above already places it there) — no separate skills-loading step needed.
Review `adapters/codex/rules/git-guard.md` and point Codex at it explicitly
if it isn't already following `AGENTS.md`'s git policy.

### Other agents
At minimum, an agent needs to read `AGENTS.md` (or an equivalent bootstrap
file) and `.ai/WORKFLOW.yaml` before making changes.
`portable-plugin/skills/*/SKILL.md` are plain markdown with YAML
frontmatter — readable as reference docs even without native Skills
support. Point the agent at
`portable-plugin/skills/software-change/SKILL.md` as the workflow entry
point.

## 4. Adapter completeness

| Adapter | Status |
|---|---|
| `claude-code` | Permissions (`ask` on git mutations) — done. |
| `codex` | Git-mutation policy restated for Codex's approval flow — done. |
| `xcode` (`ios-macos` branch only) | `prebuildScripts` snippet for XcodeGen — done. |

## What's not decided yet

Whether to additionally package this as a formal, marketplace-installable
Claude Code plugin (rather than the manual drop-in above) is an open
question — deliberately left for after the v0.5 Pilot
(tracked as issue #11), since real usage should inform whether drop-in is
good enough or a stricter package format is worth the added rigidity.

Same for validating this install flow against a genuinely new project and
an existing project (via `bootstrap-project`'s read-only inspection mode)
on all three platforms — that needs real projects to validate against, not
just this document.
