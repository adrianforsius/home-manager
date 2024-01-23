{
  config,
  pkgs,
  ...
}: {
  home.programs = {
    pkgs.xclip,
  };

  home.shellAliases = {
    pbcopy  = "xsel --clipboard --input";
    pbpaste = "xsel --clipboard --output";
  };
}
