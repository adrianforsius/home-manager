Nix's home manager to replace dotfiles

Install your os and run:
```
mkdir -p ~/.config && \
nix --extra-experimental-features flakes --extra-experimental-features nix-command run nixpkgs#git -- clone https://github.com/adrianforsius/home-manager ~/.config/home-manager && \
nix --extra-experimental-features flakes --extra-experimental-features nix-command  run home-manager/master -- switch
```

Inspired by:

- https://github.com/mitchellh/nixos-config
- https://github.com/zmre/nix-config
- https://git.daniel-siepmann.de/danielsiepmann/nixpkgs
