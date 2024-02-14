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

.PHONY: bootstrap
bootrap:
	./bootstrap.sh

