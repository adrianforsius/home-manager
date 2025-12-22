{
  pkgs,
  config,
  lib,
  ...
}: {
  # Let Home Manager install and manage itself.
  zsh = import ./zsh.nix {inherit pkgs config;};

  git = import ./program/git.nix {};
  vim = import ./program/vim.nix {inherit pkgs config;};
  starship = import ./program/starship.nix {inherit lib;};
  neovim = {
    vimAlias = true;
  };
  # nixvim = import ./program/nixvim.nix {inherit pkgs;};

  home-manager.enable = true;
  pay-respects.enable = true;
  go.enable = true;
  gpg.enable = true;
  bat.enable = true;
  dircolors.enable = true;
  jq.enable = true;
  less.enable = true;
  man.enable = true;
  diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
  # k9s.enable = true;

  # google-chrome.enable = true;
  # chromium = {
  #   enable = true;
  #   package = pkgs.google-chrome;
  # };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  ripgrep = {
    enable = true;
    arguments = ["--max-columns-preview" "--colors=line:style:bold"];
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".addKeysToAgent = "yes";
  };

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    settings = {
      enable_audio_bell = false;
    };
  };

  vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    mutableExtensionsDir = true; # to allow vscode to install extensions not available via nix
    # VSCode already has sync in the cloud
    # TODO: Replicate sync settings, for now its just easier to sync
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      hashicorp.terraform
      rust-lang.rust-analyzer
      esbenp.prettier-vscode
      bbenoist.nix
      ms-vscode.makefile-tools
      golang.go
      eamodio.gitlens
      github.copilot
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      mikestead.dotenv
      ms-python.python
      # evgeniypeshkov.syntax-highlighter
    ];
    # keybindings = [
    # ];
    profiles.default.userSettings = {
      "workbench.sideBar.location" = "right";
    };
  };

  # firefox = {
  #   enable = true;
  # };

  gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
