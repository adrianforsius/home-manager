{nixpkgs}: system:
import nixpkgs {
  inherit system;
  config = {
    allowUnsupportedSystem = true;
    allowBroken = false;
    allowUnfree = true;
    experimental-features = "nix-command flakes";
    keep-derivations = true;
    keep-outputs = true;
  };
}
