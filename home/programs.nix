{pkgs, ...}: {
  # Let Home Manager install and manage itself.
  home-manager.enable = true;
  thefuck.enable = true;
  go.enable = true;
  gpg.enable = true;
  bat.enable = true;

  git = {
    enable = true;
    userName = "Adrian Forsius";
    userEmail = "adrianforsius@gmail.com";
    # signing.gpgPath = "/usr/local/bin/gpg";
    signing.signByDefault = true;
    signing.key = "0EA152470286BFC4";

    diff-so-fancy.enable = true;

    extraConfig = {
      push.default = "matching";
      diff.tool = "code";
      merge = {
        tool = "code";
        conflictstyle = "diff3";
      };
      mergetool = {
        tool = "code";
        keepBackup = false;
      };
      pull.rebase = true;
      apply.whitespace = "fix";
      pager.branch = false;
      "color \"status\"" = {
        added = "yellow";
        changed = "green";
        untracked = "cyan";
        ui = "auto";
      };
      "color \"branch\"" = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      "color \"diff\"" = {
        meta = "yellow bold";
        frag = "magenta bold";
        old = "red";
        new = "green";
      };
    };
    aliases = {
      # View abbreviated SHA, description, and history graph of the latest 20 commits
      l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
      # View the current working tree status using the short format
      s = "status -s";
      # Show the diff between the latest commit and the current state
      d = "!git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
      # `git di $number` shows the diff between the state `$number` revisions ago and the current state
      di = "!d() { git diff --patch-with-stat head~$1; }; git diff-index --quiet HEAD -- || clear; d";
      # pull in remote changes for the current repository and all its submodules
      p = "!git pull; git submodule foreach git pull origin master";
      # clone a repository including all submodules
      c = "clone --recursive";
      # commit all changes
      ca = "!git add -a && git commit -av";
      # switch to a branch, creating it if necessary
      go = "checkout -b";
      # show verbose output about tags, branches or remotes
      tags = "tag -l";
      branches = "branch -a";
      remotes = "remote -v";
      # credit an author on the latest commit
      credit = "!f() { git commit --amend --author \"$1 <$2>\" -c HEAD; }; f";
      # interactive rebase with the given number of latest commits
      reb = "!f() { git rebase -i HEAD~$1; }; f";
      rem = "!f() { git rebase origin/master; }; f";
      # push to own branchh
      ne = "!f() { git commit --no-verify --amend --no-edit; }; f";
      # find branches containing commit
      e = "!f() { git config --global -e; }; f";
      # master rebase
      fb = "!f() { git branch -a --contains $1; }; f";
      # find tags containing commit
      ft = "!f() { git describe --always --contains $1; }; f";
      # find commits by source code
      fc = "!f() { git log --pretty=format:'%c(yellow)%h  %cblue%ad  %creset%s%cgreen  [%cn] %cred%d' --decorate --date=short -s$1; }; f";
      # find commits by commit message
      fm = "!f() { git log --pretty=format:'%c(yellow)%h  %cblue%ad  %creset%s%cgreen  [%cn] %cred%d' --decorate --date=short --grep=$1; }; f";
      # remove branches that have already been merged with master
      dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d";
      # set upstream
      up = "!git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD)";
      # push to own branchh
      po = "!git push origin \"$(git rev-parse --abbrev-ref HEAD)\"";
      # make temporal wip commit
      w = "!git commit --no-verify -m wip";
      # reset head one back
      rh = "!git reset HEAD~1";
      # list recent checked out branches
      lb = "!f() { git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)' | head -n 15; }; f";
      # list commits between dates
      lc = "!f() { git log --pretty=format:'%ad - %an: %s %h' --after='$(date --date=\"10 days ago\")' --until='$(date)'; }; f";
      # count commits since master
      ccm = "!git rev-list --count HEAD ^main";
      # interactive rebase with the given number of latest commits
      rev = "!git rev-list --count HEAD ^master";
    };
  };

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
    extraConfig =
      if pkgs.stdenv.isLinux
      then ''identityFile ~/.ssh/id_ed25519''
      else ''        identityFile ~/.ssh/id_ed25519
              UseKeyChain yes
      '';
  };

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
