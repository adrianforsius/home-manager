{ config, pkgs, specialArgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "adrianforsius";
  home.username = specialArgs.user.name;

  home.homeDirectory = specialArgs.user.home;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = import ./home/packages.nix { inherit pkgs config; };
  editorconfig = import ./editorconfig.nix { };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through "home.file".
  home.file = {
    # # Building this configuration will create a copy of "dotfiles/screenrc" in
    # # the Nix store. Activating the configuration will then make "~/.screenrc" a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''

    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # "";
  };

  # Home Manager can also manage your environment variables through
  # "home.sessionVariables". If you don't want to manage your shell through Home
  # Manager then you have to manually source "hm-session-vars.sh" located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/adrianforsius/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";

    # Enable persistent REPL history for `node`.
    NODE_REPL_HISTORY = "~/.node_history";
    # Allow 32³ entries; the default is 1000.
    NODE_REPL_HISTORY_SIZE="32768";
    # Use sloppy mode by default, matching web browsers.
    NODE_REPL_MODE="sloppy";

    # Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
    PYTHONIOENCODING="UTF-8";

    # # Increase Bash history size. Allow 32³ entries; the default is 500.
    # HISTSIZE="32768";
    # HISTFILESIZE="$(HISTSIZE)";
    # # Omit duplicates and commands that begin with a space from history.
    # HISTCONTROL="ignoreboth";

    # add time to History
    HISTTIMEFORMAT="%d/%m/%y %T ";

    # Don’t clear the screen after quitting a manual page.
    MANPAGER="less -X";

    # Prefer US English and use UTF-8.
    LANG="en_US.UTF-8";
    LC_ALL="en_US.UTF-8";

    # Highlight section titles in manual pages.
    # TODO: Fix highlight
    #LESS_TERMCAP_mb = "$(tput bold; tput setaf 2)";
    # LESS_TERMCAP_md = "$(tput bold; tput AF 3)";

    # TODO: Add to GPG service
    # GPG_TTY="$(tty)";

    VIRTUAL_ENV_DISABLE_PROMPT="0";

  };

  home.sessionPath = [
    "$HOME/sdk/go1.21.1/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.thefuck.enable = true;
  programs.go.enable = true;
  programs.gpg.enable = true;
  programs.bat.enable = true;
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
      identityFile ~/.ssh/id_ed25519
    ''; 
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = import ./home/aliases.nix { inherit pkgs config; };
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    "oh-my-zsh" = {
      enable = true;
      plugins = [ "thefuck" "aws" "docker" "history" "z" "gh" "git"];
      theme = "steeef";
    };
  };
}

