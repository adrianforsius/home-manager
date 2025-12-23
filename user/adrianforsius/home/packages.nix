{ pkgs, ... }:
with pkgs;
[
  # # Adds the "hello" command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello
  mkpasswd
  entr
  btop
  eza
  pulumi-bin
  coreutils
  wget
  tree
  grc
  curl
  gcc
  pipenv
  gnugrep
  z-lua
  netcat
  openssl
  go-swagger
  swagger-codegen
  ngrok
  minikube
  cachix
  # lynx
  tldr
  ncdu
  wireshark
  dust
  trash-cli
  duf
  neofetch
  haskellPackages.kmonad
  gxkb
  sqlite
  graphviz
  sqlitebrowser
  typescript
  # spotify
  rquickshare

  poppler-utils
  neovim

  transmission_4
  # zoom
  zoom-us
  # vscode
  # postman # TODO: 404 on mirror
  # insomnia
  # gimp
  htmlq
  unzip
  imagemagick
  xfce.thunar
  qpdfview
  vlc
  feh
  slack
  # franz
  docker
  tailscale
  google-chrome

  gopls
  python3
  nodejs

  hugo

  # nerdfonts
  # It is sometimes useful to fine-tune packages, for example, by applying
  # overrides. You can do that directly here, just don"t forget the
  # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # fonts?
  pkgs.nerd-fonts.jetbrains-mono
  pkgs.nerd-fonts.symbols-only

  # You can also create simple shell scripts directly inside your
  # configuration. For example, this adds a command "my-hello" to your
  # environment:
  # (pkgs.writeShellScriptBin "reload" ''
  #   nix run home-manager/master -- switch
  # '')
]
