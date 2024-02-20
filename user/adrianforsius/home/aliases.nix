{pkgs, ...}:
{
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # TODO: Overwrite oh-my-zsh aliases for these to take effect
  la = "eza -la";
  ls = "eza -l";
  l = "eza";

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

  ip = "dig +short myip.opendns.com @resolver1.opendns.com";
  ips = "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";
  # Intuitive map function
  # For example, to list all directories that contain a certain file:
  # find . -name .gitattributes | map dirname
  map = "xargs -n1";

  tre = "tree -I 'vendor'";

  aws-login = "aws ecr get-login --no-include-email | sh";

  d = "docker-compose";
  k = "kubectl";
  swap-clean = "rm -f ~/.vim/swaps/.*; rm -f ~/.vim/swaps/*";
  pubkey = "cat ~/.ssh/id_ed25519.pub | pbcopy";
}
// pkgs.lib.optionals pkgs.stdenv.isLinux {
  pbcopy = "xsel --clipboard --input";
  pbpaste = "xsel --clipboard --output";
  open = "xdg-open";
}
