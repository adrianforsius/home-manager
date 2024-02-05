{pkgs}: {
  defaults =
    if pkgs.stdenv.isDarwin
    then
      pkgs.std {
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain.InitialKeyRepeat = 10;
        NSGlobalDomain.KeyRepeat = 1;
        NSGlobalDomain.AppleKeyboardUIMode = 3;
        NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
        NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
        NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1;
        dock.autohide = true;
        dock.mru-spaces = false;
        dock.show-recents = false;
        dock.static-only = true;
        dock.expose-animation-duration = 0.01;
        finder.AppleShowAllExtensions = true;
        finder.FXEnableExtensionChangeWarning = false;
        loginwindow.GuestEnabled = false;
      }
    else {};
}
