#!/usr/bin/env bash

mkdir -p ~/.config && \
nix --extra-experimental-features flakes --extra-experimental-features nix-command run nixpkgs#git -- clone https://github.com/adrianforsius/home-manager ~/.config/home-manager && \
nix --extra-experimental-features flakes --extra-experimental-features nix-command  run home-manager/master -- switch
