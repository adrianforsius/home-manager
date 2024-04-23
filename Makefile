PROFILE ?= ${PROFILE}

.PHONY: switch
switch:
	nix run home-manager/release-23.11 -- switch --flake .#"${PROFILE}"

.PHONY: build
build:
	nix run home-manager/release-23.11 -- build --flake .#"${PROFILE}"

.PHONY: fmt
fmt:
	find . -name "*.nix" | xargs nix develop --command alejandra

.PHONY: build-nix
build-nix:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${PROFILE}"


.PHONY: bootstrap
bootrap:
	./bootstrap.sh


.PHONY: config
config:
	NIX_CONFIG="experimental-features = nix-command flakes" \
	nix run nixpkgs#git -- clone https://github.com/adrianforsius/home-manager ~/.config/home-manager

