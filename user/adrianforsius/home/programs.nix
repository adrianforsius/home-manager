{pkgs, ...}:
with pkgs; {
  # Let Home Manager install and manage itself.

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
      if stdenv.isLinux
      then ''identityFile ~/.ssh/id_ed25519''
      else ''        identityFile ~/.ssh/id_ed25519
              UseKeyChain yes
      '';
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

  vim = {
    enable = true;
    extraConfig = ''
      " Filetype indent with plugin possibility load after vundle to avoid errors
      filetype indent plugin on

      colorscheme gruvbox

      " Make Vim more useful
      set nocompatible
      set clipboard=unnamedplus

      " Enhance command-line completion
      set wildmode=longest,list
      set wildmenu
      " Allow cursor keys in insert mode
      set esckeys
      " Allow backspace in insert mode
      set backspace=indent,eol,start
      " Optimize for fast terminal connections
      set ttyfast
      " Add the g flag to search/replace by default
      set gdefault
      " Use UTF-8 without BOM
      set encoding=utf-8 nobomb
      " Change mapleader
      let mapleader=","
      " Don’t add empty newlines at the end of files
      set binary
      set noeol

      " Don’t create backups when editing files in certain directories
      set backupskip=/tmp/*,/private/tmp/*

      " Set history commandline (q:) history size
      set viminfo+=:10000

      " Respect modeline in files
      set modelines=4
      " Enable per-directory .vimrc files and disable unsafe commands in them
      set exrc
      set secure
      " Enable syntax highlighting
      syntax on
      " Highlight current line
      set cursorline
      " Highlight current column
      set cursorcolumn
      " Show “invisible” characters
      set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
      set list
      " Highlight searches
      set hlsearch
      " Highlight dynamically as pattern is typed
      set incsearch
      " Always show status line
      set laststatus=2
      " Disable error bells
      set noerrorbells
      " Don’t reset cursor to start of line when moving around.
      set nostartofline
      " Show the cursor position
      set ruler
      " Don’t show the intro message when starting Vim
      set shortmess=atI
      " Show the current mode
      set showmode
      " Show the filename in the window titlebar
      set title
      " Show the (partial) command as it’s being typed
      set showcmd
      " Better display for messages
      set cmdheight=2

      " Set autowrite to leverage go-vims quickfix
      set autowrite

      " Mappings
      " Only tracked files - for source with lot of static
      nnoremap <C-L> :GFiles<cr>
      " All files
      nnoremap <C-p> :FZF<cr>

      " Enter after search will cancel highlighting
      nnoremap <cr> :noh<cr><cr>

      nnoremap <leader>cf :let @*=expand("%")<CR>
      nnoremap <leader>cd :let @*=expand("%:h")<CR>
      " vim-go
      nnoremap <leader>.a :cclose<CR>
      nnoremap <leader>.b :GoBuild<cr>
      nnoremap <leader>.c :GoCoverageToggle<cr>
      nnoremap <leader>.d :GoDecls<cr>
      nnoremap <leader>.e :GoErrCheck<cr>
      nnoremap <leader>.f :GoFillStruct<cr>
      nnoremap <leader>.g :GoDeclsDir<cr>
      nnoremap <leader>.k :GoDocBrowser<cr>
      nnoremap <leader>.g :GoKeyify<cr>
      nnoremap <leader>.l :GoLint<cr>
      nnoremap <leader>.m :GoMetaLinter<cr>
      nnoremap <leader>.i :GoIfErr<cr>
      nnoremap <leader>.v :GoVet<cr>

      " vim-go settings
      let g:go_fmt_command    = "goimports"
      let g:go_auto_type_info = 1
      let g:go_def_mode       = "gopls"
      let g:go_info_mode      = "gopls"
      let g:go_list_type      = "quickfix"
      let g:go_addtags_transform = "camelcase"

      " easy motion
      let g:EasyMotion_do_mapping = 0
      nmap <leader>m <Plug>(easymotion-overwin-f2)

      " gitgutter
      set updatetime=400

      " toggle spell
      nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

      command! -nargs=+ Gg execute 'silent grep! -r <args> *' | copen 10

      " Suggestion: By default, govim populates the quickfix window with diagnostics
      " reported by gopls after a period of inactivity, the time period being
      " defined by updatetime (help updatetime). Here we suggest a short updatetime
      " time in order that govim/Vim are more responsive/IDE-like
      set updatetime=500

      " Suggestion: To make govim/Vim more responsive/IDE-like, we suggest a short
      " balloondelay
      set balloondelay=250

      " Suggestion: Turn on the sign column so you can see error marks on lines
      " where there are quickfix errors. Some users who already show line number
      " might prefer to instead have the signs shown in the number column; in which
      " case set signcolumn=number (requires Vim >= v8.1.1564)
      set signcolumn=yes

      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

      let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    '';
    plugins = [
      # Triage:
      # vimPlugins.copilot-vim
      vimPlugins.editorconfig-vim
      vimPlugins.fzf-vim
      vimPlugins.vim-commentary
      vimPlugins.vim-easymotion
      vimPlugins.vim-fugitive
      vimPlugins.vim-gitgutter
      vimPlugins.vim-go
      vimPlugins.vim-rhubarb

      # LSP
      vimPlugins.asyncomplete-lsp-vim
      vimPlugins.asyncomplete-vim
      vimPlugins.asyncomplete-vim
      vimPlugins.vim-lsp
      vimPlugins.vim-lsp-settings

      # theme
      vimPlugins.gruvbox
    ];
    settings = {
      # mouse = "a";
      background = "dark";
      backupdir = ["~/.vim/backups"];
      directory = ["~/.vim/swaps"];
      expandtab = true;
      hidden = true;
      history = 10000;
      ignorecase = true;
      modeline = true;
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 2;
      undodir = ["~/.vim/undo"];
      undofile = true;
    };
  };
  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$typst"
        "$vlang"
        "$vagrant"
        "$zig"
        "$buf"
        "$nix_shell"
        "$conda"
        "$meson"
        "$spack"
        "$memory_usage"
        # "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$direnv"
        "$env_var"
        "$crystal"
        "$custom"
        "$sudo"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$os"
        "$container"
        "$shell"

        # end of prompt
        "$linebreak"
        "$character"
      ];
      directory = {
        truncate_to_repo = false;
        truncation_length = 0;
      };
      scan_timeout = 10;
      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
      };
    };
  };
}
