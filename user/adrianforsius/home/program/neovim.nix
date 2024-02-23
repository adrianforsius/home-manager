{pkgs, ...}: {
  enable = true;

  plugins = with pkgs.vimPlugins; [
    # Triage:
    # vimPlugins.copilot-vim
    editorconfig-vim
    # fzf-vim
    # vim-commentary
    # vim-easymotion
    # vim-fugitive
    # vim-gitgutter
    # vim-go
    # vim-rhubarb
    # trouble-nvim

    # theme
    # gruvbox
  ];

  extraConfig = ''
  '';
  extraLuaConfig = ''
  '';
}
