ACTIVATION_USER ?= ${USER}
ACTIVATION_HOST ?= $(shell hostname)

.PHONY: switch
switch:
	nix run home-manager/release-23.11 -- switch --flake .#"${ACTIVATION_USER}@${ACTIVATION_HOST}"

.PHONY: build
build:
	nix run home-manager/release-23.11 -- build --flake .#"${ACTIVATION_USER}@${ACTIVATION_HOST}"

.PHONY: fmt
fmt:
	find . -name "*.nix" | xargs nix develop --command alejandra

.PHONY: bootstrap
bootrap:
	./bootstrap.sh

