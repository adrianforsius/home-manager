PROFILE ?= ${PROFILE}

.PHONY: switch
switch:
	nix run home-manager/master -- switch --flake .#"${PROFILE}"

.PHONY: build
build:
	nix run home-manager/master -- build --flake .#"${PROFILE}"

.PHONY: check
check:
	nix flake check

.PHONY: fmt
fmt:
	find . -name "*.nix" | xargs nix develop --command nixfmt

.PHONY: build-nix
build-nix:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${PROFILE}"


.PHONY: bootstrap
bootstrap:
	./bootstrap.sh


.PHONY: config
config:
	NIX_CONFIG="experimental-features = nix-command flakes" \
	nix run nixpkgs#git -- clone https://github.com/adrianforsius/home-manager ~/.config/home-manager

