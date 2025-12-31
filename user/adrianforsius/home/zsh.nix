{
  pkgs,
  config,
  ...
}:
{
  enable = true;
  shellAliases = import ./aliases.nix { inherit pkgs config; };
  autosuggestion.enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  "oh-my-zsh" = {
    enable = true;
    plugins = [
      "aws"
      "docker"
      "history"
      "z"
      "gh"
      "git"
    ];
    # theme = "steeef";
  };

  history = {
    expireDuplicatesFirst = true;
    ignoreSpace = true;
    ignoreDups = true;
    extended = true;
    share = true;
    save = 1000000; # save 1,000,000 lines of history
    size = 1000000;
  };
}
