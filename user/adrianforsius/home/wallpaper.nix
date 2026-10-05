# Coffee wallpaper with an i3 cheatsheet drawn on the left. Keep in sync with xsession.nix.
{ pkgs }:
let
  row =
    key: action:
    "${key}${
      pkgs.lib.concatStrings (pkgs.lib.replicate (18 - builtins.stringLength key) " ")
    }${action}";
  lines = [
    "I3 CHEATSHEET   (Super = Mod4)"
    ""
    "LAUNCH"
    (row "Super+Space" "rofi combi")
    (row "Super+o" "rofi run")
    (row "Super+Shift+o" "rofi windows")
    (row "Super+n" "new kitty")
    (row "Super+w" "kill window")
    ""
    "FOCUS / MOVE"
    (row "Super+h/j/k/l" "focus (vim keys)")
    (row "Super+Shift+hjkl" "move window")
    (row "Super+Shift+a" "focus parent")
    (row "Super+1..0" "go to workspace")
    (row "Super+Shift+1..0" "move to workspace")
    ""
    "LAYOUT"
    (row "Super+d" "split horizontal")
    (row "Super+Shift+d" "split vertical")
    (row "Super+Shift+s" "stacking")
    (row "Super+Shift+w" "tabbed")
    (row "Super+Shift+e" "toggle split")
    (row "Super+Shift+f" "fullscreen")
    (row "Super+Shift+Space" "floating toggle")
    (row "Super+r" "resize mode (hjkl)")
    ""
    "SYSTEM"
    (row "Super+Shift+x" "shot area > clip")
    (row "Super+Shift+z" "shot window > clip")
    (row "Super+, / ." "volume down / up")
    (row "Super+Ctrl+l" "lock screen")
    (row "Super+Backspace" "exit/reboot/off")
    (row "Super+Shift+r" "restart i3")
  ];
  text = pkgs.writeText "i3-cheatsheet.txt" (pkgs.lib.concatStringsSep "\n" lines);
in
pkgs.runCommand "wallpaper-coffee-cheatsheet.jpg" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
  magick ${./asset/coffe2-2560x1440.jpg} \
    -fill '#000000b0' -draw 'roundrectangle 290,110 930,1240 18,18' \
    -font ${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFontMono-Bold.ttf \
    -pointsize 22 -interline-spacing 3 -fill '#ebdbb2' \
    -annotate +322+150 "$(cat ${text})" \
    -quality 92 $out
''
