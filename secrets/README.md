# Secrets (sops-nix)

Encrypted with [sops](https://github.com/getsops/sops) using age. Only encrypted files live here.
The private key is never committed.

- Editing key: `~/.config/sops/age/keys.txt` (public key is in `../.sops.yaml`)
- Host key used at activation: `/var/lib/sops-nix/key.txt` (root-only copy)

## Set or change a secret

```
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix shell nixpkgs#sops -c sops secrets/wifi.yaml
```

Replace the value of `home_psk` in the editor and save. Do not put secrets on a command line.

## Install the host key (once per machine, before switching)

```
sudo install -D -m 600 -o root -g root ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
```

Back up `~/.config/sops/age/keys.txt` in your password manager. If it is lost the secrets
cannot be recovered and must be re-created.

## Add a new machine or recipient

Add its age public key to `../.sops.yaml`, then run `sops updatekeys secrets/<file>.yaml`.
