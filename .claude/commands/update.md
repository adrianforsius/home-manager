---
description: Update flake inputs, fix breakage, validate all hosts, and review the result
---

Run the maintenance pipeline for this repo. Never switch the system.

1. Launch the `flake-updater` agent (in a worktree via `isolation: "worktree"`) to update inputs and fix breakage.
   Extra instructions from the user: $ARGUMENTS
2. When it finishes, launch `nix-validator` and `nix-reviewer` in parallel against the worktree's changes.
3. Summarize for the user: lock changes, edits made, validation table, and review findings. Do not commit or merge until the user approves.
