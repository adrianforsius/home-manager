{...}: {
  # TODO: move more i3 config from file to here
  windowManager.i3.config = {
    enable = true;
    startup = [
      {
        command = "feh --bg-fill ~/.wallpaper.jpg";
        always = true;
        notification = false;
      }
      {
        command = "nm-applet";
        notification = false;
      }
    ];
  };
}
