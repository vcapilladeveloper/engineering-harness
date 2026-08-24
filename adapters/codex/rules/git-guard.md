# Git Mutation Policy (Codex)

Matches `.ai/WORKFLOW.yaml`'s `git` block.

Read-only, always fine: `git status`, `git diff`, `git log`, `git show`.

Everything that mutates repo state — `switch`, `checkout`, `branch`, `add`,
`commit`, `pull`, `push`, `merge`, `rebase`, `reset`, `cherry-pick`, `stash` —
requires the human to explicitly ask for it in that turn. Run Codex with an
approval mode that prompts on these instead of running them silently (check
`codex --help` for the current flag — it has been renamed across releases).
