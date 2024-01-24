{ pkgs, config, ... }:

with pkgs; [
  # # Adds the "hello" command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello
  git
  eza
  pulumi-bin
  coreutils
  wget
  tree
  grc
  curl
  docker
  gcc
  gnugrep
  z-lua
  netcat

  python3
  nodejs_21

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
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
  whatsapp-for-linux
  xclip
]

