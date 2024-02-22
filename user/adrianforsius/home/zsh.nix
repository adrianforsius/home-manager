{
  pkgs,
  config,
  ...
}: {
  enable = true;
  shellAliases = import ./aliases.nix {inherit pkgs config;};
  enableAutosuggestions = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  "oh-my-zsh" = {
    enable = true;
    plugins = ["thefuck" "aws" "docker" "history" "z" "gh" "git"];
    # theme = "steeef";
  };

  history = {
    expireDuplicatesFirst = true;
    ignoreSpace = true;
    ignoreDups = true;
    extended = true;
    share = true;
    save = 10000; # save 10,000 lines of history
    size = 100000;
  };
}
