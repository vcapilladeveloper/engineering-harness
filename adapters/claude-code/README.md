# Claude Code Adapter

Translates `.ai/WORKFLOW.yaml`'s policy into Claude Code's actual enforcement
mechanisms.

- **`permissions/settings.json`** — merge into the project's
  `.claude/settings.json`. Puts git mutation commands under `ask` (prompt
  every time) and read-only git commands under `allow`, matching
  `WORKFLOW.yaml`'s `git.mutations` / `git.read_only_allowed`.
- **`hooks/`** — empty by default. Add a hook here only when a permission
  rule isn't enough (e.g. blocking implementation before a Spec exists in
  `.ai/specs/`). See Claude Code's hooks docs for the `PreToolUse` /
  `PostToolUse` format.
