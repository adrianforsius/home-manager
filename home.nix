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
  programs.git = {
    enable = true;
    userName = "Adrian Forsius";
    userEmail = "adrianforsius@gmail.com";
    # signing.gpgPath = "/usr/local/bin/gpg";
    signing.signByDefault = true;
    signing.key = "6FADEE05C3DE7B1A";

    aliases = {
      # View abbreviated SHA, description, and history graph of the latest 20 commits
      l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
      # View the current working tree status using the short format
      s = "status -s";
      # Show the diff between the latest commit and the current state
      # d = !"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat"
      ## `git di $number` shows the diff between the state `$number` revisions ago and the current state
      #di = !"d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d"
      ## Pull in remote changes for the current repository and all its submodules
      #p = !"git pull; git submodule foreach git pull origin master"
      ## Clone a repository including all submodules
      #c = clone --recursive
      ## Commit all changes
      #ca = !git add -A && git commit -av
      ## Switch to a branch, creating it if necessary
      #go = checkout -B
      ## Show verbose output about tags, branches or remotes
      #tags = tag -l
      #branches = branch -a
      #remotes = remote -v
      ## Credit an author on the latest commit
      #credit = "!f() { git commit --amend --author \"$1 <$2>\" -C HEAD; }; f"
      ## Interactive rebase with the given number of latest commits
      #rev = "!f() { git rev-list --count HEAD ^master; }; f"
      ## Interactive rebase with the given number of latest commits
      #reb = "!f() { git rebase -i HEAD~$1; }; f"
      ##
      #rem = "!f() { git rebase origin/master; }; f"
      ## Push to own branchh
      #ne = "!f() { git commit --no-verify --amend --no-edit; }; f"
      ## Find branches containing commit
      #e = "!f() { git config --global -e; }; f"
      ## Master rebase
      #fb = "!f() { git branch -a --contains $1; }; f"
      ## Find tags containing commit
      #ft = "!f() { git describe --always --contains $1; }; f"
      ## Find commits by source code
      #fc = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f"
      ## Find commits by commit message
      #fm = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f"
      ## Remove branches that have already been merged with master
      #dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"
      ## set upstream
      #up = "!git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD)"
      ## Push to own branchh
      #po = "!git push origin \"$(git rev-parse --abbrev-ref HEAD)\""
      ## Make temporal wip commit
      #w = "!git commit --no-verify -m wip"
      ## Reset head one back
      #rh = "!git reset HEAD~1"
      ## List recent checked out branches
      #lb = "!f() { git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)' | head -n 15; }; f"
      ## List commits between dates
      #lc = "!f() { git log --pretty=format:'%ad - %an: %s %H' --after='$(date --date=\"10 days ago\")' --until='$(date)'; }; f"
      ## count commits since master
      #ccm = "!git rev-list --count HEAD ^master"
    };
  };
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
      extraConfig = if pkgs.stdenv.isLinux then ''identityFile ~/.ssh/id_ed25519'' else ''identityFile ~/.ssh/id_ed25519 UseKeyChain yes'';
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
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentryFlavor = "qt";
    enableScDaemon = false;
  };

}

