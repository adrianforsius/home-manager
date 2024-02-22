{
  pkgs,
  config,
  ...
}: {
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
  plugins = with pkgs.vimPlugins; [
    # Triage:
    # vimPlugins.copilot-vim
    editorconfig-vim
    fzf-vim
    vim-commentary
    vim-easymotion
    vim-fugitive
    vim-gitgutter
    vim-go
    vim-rhubarb

    # LSP
    # vimPlugins.asyncomplete-lsp-vim
    # vimPlugins.asyncomplete-vim
    # vimPlugins.asyncomplete-vim
    # vimPlugins.vim-lsp
    # vimPlugins.vim-lsp-settings

    # theme
    gruvbox
  ];

  settings = {
    # mouse = "a";
    background = "dark";
    backupdir = ["${config.home.homeDirectory}/.vim/backups"];
    directory = ["${config.home.homeDirectory}/.vim/swaps"];
    expandtab = true;
    hidden = true;
    history = 10000;
    ignorecase = true;
    modeline = true;
    number = true;
    relativenumber = true;
    shiftwidth = 4;
    tabstop = 2;
    undodir = ["${config.home.homeDirectory}/.vim/undo"];
    undofile = true;
  };
}
