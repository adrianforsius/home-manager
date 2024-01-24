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
  gcc
  gnugrep
  z-lua
  netcat
  go-swagger
  swagger-codegen
  ngrok

  zoom
  vscode
  # postman # TODO: 404 on mirror
  insomnia
  gimp
  qpdfview
  vlc
  slack
  franz
  docker
  virtualbox
  google-chrome

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
  teams-for-linux
  whatsapp-for-linux
  xclip
  xfce.xfce4-terminal
  pacman
  albert
] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
  iterm2
]

