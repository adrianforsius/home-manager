{...}: {
  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    # public binary cache that I use for all my derivations. You can keep
    # this, use your own, or toss it. Its typically safe to use a binary cache
    # since the data inside is checksummed.
    settings = {
      substituters = ["https://cache.nixos.org" "https://adrianforsius.cachix.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "adrianforsius.cachix.org-1:dqiGV3J707B/aFdb8YS2u59G50jcgNUabpcw1vOq/e4="];
    };
  };

  users.users.adrianforsius = {
    home = "/Users/adrianforsius";
    shell = pkgs.zsh;
  };
}
