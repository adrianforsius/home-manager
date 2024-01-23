# { config, pkgs, extraSpecialArgs, ... }:
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "adrianforsius";
  # home.username = extraSpecialArgs.user.name;

  # home.homeDirectory = extraSpecialArgs.user.home;
  home.homeDirectory = "/home/adrianforsius";

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
  home.packages = [
    # # Adds the "hello" command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.nodejs_21
    pkgs.git
    pkgs.eza

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don"t forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command "my-hello" to your
    # # environment:
    (pkgs.writeShellScriptBin "reload" ''
      nix run home-manager/release-${config.home.stateVersion} -- switch
    '')
  ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";

        end_of_line = "LF";
        insert_final_newline = true;
        trim_trailing_whitespace = true;

        indent_style = "space";
        indent_size = 4;
      };

      "Makefile" = {
        indent_style = "tab";
      };

      "*.go" = {
        indent_style = "tab";
        indent_size = 8;
      };

      ".vimrc" = {
        indent_style = "tab";
        indent_size = 2;
      };

      ".*" = {
        indent_style = "space";
        indent_size = 2;
      };

      "*.sh" = {
        indent_style = "space";
        indent_size = 2;
      };

      "[{*.json,*.js,*.ts}]" = {
        indent_style = "space";
        indent_size = 2;
      };

      "[{*.yaml,*.yml}]" = {
        indent_style = "space";
        indent_size = 2;
      };
    };
  };

  home.shellAliases = {
    ".."    = "cd ..";
    "..."   = "cd ../..";
    "...."  = "cd ../../..";
    "....." = "cd ../../../..";

    # TODO: Overwrite oh-my-zsh aliases for these to take effect
    la = "eza -la";
    ls = "eza -l";
    l  = "eza";

    dl = "cd ~/Downloads";
    dt = "cd ~/Desktop";

    g = "git";
    h = "history";
    j = "jobs";

    grep = "grep --color=auto";

    # Enable aliases to be sudo’ed
    sudo = "sudo ";

    # View HTTP traffic
    sniff = "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'";
    httpdump = "sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"";

    # Trim new lines and copy to clipboard
    c = "tr -d '\n' | pbcopy";

    week = "date +%V";

    ip  = "dig +short myip.opendns.com @resolver1.opendns.com";
    ips = "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";
    # Intuitive map function
    # For example, to list all directories that contain a certain file:
    # find . -name .gitattributes | map dirname
    map = "xargs -n1";

    tre = "tree -I 'vendor'";

    aws-login = "aws ecr get-login --no-include-email | sh";

    d = "docker-compose";
    k = "kubectl";
    swap-clean = "rm -f $HOME/.vim/swaps/.*; rm -f $HOME/.vim/swaps/*";
  };


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

    # Increase Bash history size. Allow 32³ entries; the default is 500.
    HISTSIZE="32768";
    HISTFILESIZE="$(HISTSIZE)";
    # Omit duplicates and commands that begin with a space from history.
    HISTCONTROL="ignoreboth";

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # } import "${extraSpecialArgs.user.load}" { inherit pkgs config;}
  # // pkgs.stdenv.isLinux [(import ./linux.nix { inherit pkgs config;})]
}

