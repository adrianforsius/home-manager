{
  pkgs,
  config,
  ...
}:
with pkgs; {
  # Let Home Manager install and manage itself.
  zsh = import ./zsh.nix {inherit pkgs config;};

  git = import ./program/git.nix {};
  vim = import ./program/vim.nix {inherit pkgs config;};
  starship = import ./program/starship.nix {inherit lib;};
  # neovim = import ./program/neovim.nix {inherit pkgs;};
  # nixvim = import ./program/nixvim.nix {inherit pkgs;};

  home-manager.enable = true;
  thefuck.enable = true;
  go.enable = true;
  gpg.enable = true;
  bat.enable = true;
  dircolors.enable = true;
  jq.enable = true;
  less.enable = true;
  man.enable = true;
  k9s.enable = true;

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
    addKeysToAgent = "yes";
  };

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  vscode = {
    enable = true;
    mutableExtensionsDir =
      true; # to allow vscode to install extensions not available via nix
    # VSCode already has sync in the cloud
    # TODO: Replicate sync settings, for now its just easier to sync
    # extensions = with vscode-extensions; [
    #   vscodevim.vim
    #   hashicorp.terraform
    #   rust-lang.rust-analyzer
    #   esbenp.prettier-vscode
    #   bbenoist.nix
    #   ms-vscode.makefile-tools
    #   golang.go
    #   eamodio.gitlens
    #   github.copilot
    #   dbaeumer.vscode-eslint
    #   editorconfig.editorconfig
    #   mikestead.dotenv
    #   ms-python.python
    # ];
    # keybindings = [
    # ];
    # userSettings = {
    # };
  };

  firefox = {
    enable = true;
  };

  gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
