# Repo guide

Nix flake for NixOS, nix-darwin and home-manager (user `adrianforsius`).

## Layout

- `flake.nix` — inputs and outputs; hosts are built through `lib/mksystem.nix`.
- `machine/<host>.nix` + `machine/hardware/<host>.nix` — per-host system config.
- `user/adrianforsius/` — user config shared across hosts:
  - `home.nix` is common; `home-linux.nix`, `home-nixos.nix`, `home-darwin.nix` are platform layers.
  - `nixos.nix` / `darwin.nix` — system-level user settings.
  - `home/` — programs, packages, zsh, stylix, xsession etc.; `home/program/` holds per-program modules.

## Outputs

- `nixosConfigurations`: `cx1carbon` (ThinkPad laptop), `corei5-home` (desktop), `vm-intel` (VM)
- `darwinConfigurations`: `macbook-pro-m1`
- `homeConfigurations."adrianforsius@adrian"` (standalone, x86_64-linux)

Anything under `user/adrianforsius/home.nix` or `home/` affects every host, including Darwin. Linux-only
packages and options belong in `home-linux.nix` / `home-nixos.nix`.

## Rules

- **Never run `switch`, `nixos-rebuild switch`, `darwin-rebuild switch` or `make switch`/`build-nix`.** Only build,
  eval and check. The user applies changes themselves.
- Format with `nixfmt` (the pre-commit hook); `make fmt` runs it.
- `nix flake check` runs the formatting hook; `statix` and `nixd` are available in `nix develop`.
- Flake inputs follow `nixpkgs` (nixos-unstable). The `nixvim` input is the user's own fork `adrianforsius/flake-vim`.
- Do not commit unrelated working-tree changes; stage files explicitly.

## Verifying changes

```
nix flake check
nix build .#nixosConfigurations.<host>.config.system.build.toplevel --dry-run
nix eval --raw .#darwinConfigurations.macbook-pro-m1.system.drvPath   # Darwin evaluates on Linux but cannot be built here
nix build .#homeConfigurations."adrianforsius@adrian".activationPackage --dry-run
```

## Agents (`.claude/agents/`)

- `nix-reviewer` — read-only diff review (cross-host impact, option validity, conventions)
- `nix-validator` — runs check/eval/dry builds for affected hosts and reports
- `flake-updater` — flake input updates and migration of deprecated options (use in a worktree)
- `option-researcher` — looks up current NixOS / home-manager / nixvim option names

Command: `/update` chains updater, validator and reviewer.
