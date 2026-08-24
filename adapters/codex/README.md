# Codex Adapter

Codex reads `AGENTS.md` automatically, so most of this harness's policy
already applies without extra config — the git-mutation and approval rules
below restate that policy for Codex's approval flow, they aren't enforced by
a permissions file the way Claude Code's are.

- **`rules/git-guard.md`** — the git-mutation policy restated for Codex.
  Point Codex at it explicitly if it isn't picking up `AGENTS.md`.
- **`permissions/`**, **`hooks/`** — left empty. Codex doesn't have Claude
  Code's settings.json permission/hook system; enforce the workflow via
  `--ask-for-approval` / sandbox flags at invocation time instead (check
  `codex --help` for the exact flags on your installed version — they've
  changed across releases).
