{...}: {
  enable = true;

  mime.enable = true;

  configFile = {
    # "mimeapps.list".force = true;
    # "i3/config".text = builtins.readFile ./config/i3;
    "rofi/config.rasi".text = builtins.readFile ./config/rofi;
    "kmonad/poker4.kbd".text = builtins.readFile ./config/poker4.kbd;
  };

  mimeApps = {
    enable = true;
    # Use file --mime-type <filename> to detect mime type
    defaultApplications = {
      # TODO: set good defaults
      # "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      # "text/calendar" = [ "org.kde.korganizer.desktop" ];
      # "application/pdf" = [ "feh.desktop" ];

      # Images
      "image/bmp" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "image/jpg" = ["feh.desktop"];
      "image/pjpeg" = ["feh.desktop"];
      "image/png" = ["feh.desktop"];
      "image/tiff" = ["feh.desktop"];
      "image/webp" = ["feh.desktop"];
      "image/x-bmp" = ["feh.desktop"];
      "image/x-pcx" = ["feh.desktop"];
      "image/x-png" = ["feh.desktop"];
      "image/x-portable-anymap" = ["feh.desktop"];
      "image/x-portable-bitmap" = ["feh.desktop"];
      "image/x-portable-graymap" = ["feh.desktop"];
      "image/x-portable-pixmap" = ["feh.desktop"];
      "image/x-tga" = ["feh.desktop"];
      "image/x-xbitmap" = ["feh.desktop"];

      # Audio
      "audio/mpeg" = ["vlc.desktop"];

      # Video
      "video/mp4" = ["vlc.desktop"];
      "video/m4v" = ["vlc.desktop"];
      "video/x-matroska" = ["vlc.desktop"];
      "video/quicktime" = ["vlc.desktop"];

      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
      # "text/html" = "google-chrome-stable.desktop";
      # "x-scheme-handler/http" = "google-chrome-stable.desktop";
      # "x-scheme-handler/https" = "google-chrome-stable.desktop";
      # "x-scheme-handler/about" = "google-chrome-stable.desktop";
      # "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
    };
  };
}
