{config, ...}: let
  modifier = config.xsession.windowManager.i3.config.modifier;
in {
  enable = true;

  # TODO: move more i3 config from file to here
  windowManager.i3 = {
    enable = true;
    config = {
      startup = [
        {
          command = "feh --bg-fill ~/.wallpaper.jpg";
          always = true;
          notification = true;
        }
        {
          command = "nm-applet";
          notification = false;
        }
        {
          command = "blueman-applet";
        }
        {command = "kitty";}
        {command = "slack";}
        # {command = "code";}
        # {command = "nvim";}
        {command = "google-chrome-stable";}
      ];

      fonts = {
        names = ["monospace"];
        style = "Bold";
        # size = lib.mkForce 11.0;
      };

      bars = [
        {
          position = "top";
          statusCommand = "i3status";

          workspaceButtons = true;
          workspaceNumbers = true;

          fonts = {
            names = ["monospace"];
            style = "Bold";
            size = 14.0;
          };
        }
      ];

      assigns = {
        "1: term" = [
          {class = "^kitty$";}
        ];
        "2: web" = [
          # {class = "^code$";}
          # {class = "^nvim$";}
          # {class = "^google\-chrome\-stable$";}
          # {class = "^Google\ Chrome$";}
          {class = "chrome";}
        ];
        "3: slack" = [
          {class = "^Slack$";}
        ];
      };

      modifier = "Mod4";
      keybindings = {
        "${modifier}+space" = "exec rofi -show combi -modes combi -combi-modes \"window#drun#run\"";
        "${modifier}+o" = "exec rofi -show run";
        "${modifier}+Shift+o" = "exec rofi -show window";
        "${modifier}+n" = "exec kitty";
        "${modifier}+d" = "split h";
        "${modifier}+Shift+d" = "split v";

        # kill focused window
        "${modifier}+w" = "kill";

        # change focus
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        # move focused window
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        # enter fullscreen mode for the focused container
        "${modifier}+Shift+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${modifier}+Shift+s" = "layout stacking";
        "${modifier}+Shift+w" = "layout tabbed";
        "${modifier}+Shift+e" = "layout toggle split";

        # toggle tiling / floating
        "${modifier}+Shift+space" = "floating toggle";

        # change focus between tiling / floating windows
        # "${modifier}+space" = "focus mode_toggle";

        # focus the parent container
        "${modifier}+Shift+a" = "focus parent";

        # reload the configuration file: not applicable for nixos
        # "${modifier}+Shift+c" = "reload";
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${modifier}+Shift+r" = "restart";

        # select and copy to clipboard
        "${modifier}+Shift+x" = "exec maim -s | xclip -selection clipboard -t image/png";

        # screenshot active window to clipboard
        "${modifier}+Shift+z" = "exec maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";

        # volume
        # "${modifier}+comma" = "exec amixer set Master -q 5%-";
        # "${modifier}+period" = "exec amixer set Master -q 5%+";
        "${modifier}+comma" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "${modifier}+period" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";

        # volume
        "${modifier}+Ctrl+l" = "exec i3lock-fancy --nofork -p";
      };
    };
    extraConfig = ''
      set $mod Mod4

      #----------------------------------------------------------------------
      # Look & Feel
      #----------------------------------------------------------------------
      # Font for window titles. Will also be used by the bar unless a different font
      # is used in the bar {} block below.
      font pango:Noto Sans Regular 14

      # Window visuals
      new_window pixel 2
      new_float pixel 2
      floating_minimum_size 400 x 300
      floating_maximum_size -1 x -1
      focus_follows_mouse no

      # Reading colors from resources
      set_from_resource $back			i3wm.background #1D1F21
      set_from_resource $black		i3wm.color0		#282A2E
      set_from_resource $grey			i3wm.color8		#373B41
      set_from_resource $lightgrey	i3wm.color7		#707880
      set_from_resource $white		i3wm.color15	#C5C8C6
      set_from_resource $yellow		i3wm.color11	#F0C674
      set_from_resource $red			i3wm.color9		#CC6666
      set_from_resource $darkred		i3wm.color1		#A54242
      set_from_resource $green		i3wm.color10	#B5BD56

      #class                  border      backgr.     text        split
      client.focused          $green      $green      $black      $red
      client.focused_inactive $grey       $grey       $lightgrey  $grey
      client.unfocused        $grey       $grey       $lightgrey  $grey
      client.urgent           $red        $red        $black      $red
      client.background       $back

      #----------------------------------------------------------------------
      # Keybindings
      #----------------------------------------------------------------------
      # Use Mouse+$mod to drag floating windows to their wanted position
      floating_modifier $mod

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      # switch to workspace
      bindsym $mod+1 workspace number $ws1
      bindsym $mod+2 workspace number $ws2
      bindsym $mod+3 workspace number $ws3
      bindsym $mod+4 workspace number $ws4
      bindsym $mod+5 workspace number $ws5
      bindsym $mod+6 workspace number $ws6
      bindsym $mod+7 workspace number $ws7
      bindsym $mod+8 workspace number $ws8
      bindsym $mod+9 workspace number $ws9
      bindsym $mod+0 workspace number $ws10

      # move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace number $ws1
      bindsym $mod+Shift+2 move container to workspace number $ws2
      bindsym $mod+Shift+3 move container to workspace number $ws3
      bindsym $mod+Shift+4 move container to workspace number $ws4
      bindsym $mod+Shift+5 move container to workspace number $ws5
      bindsym $mod+Shift+6 move container to workspace number $ws6
      bindsym $mod+Shift+7 move container to workspace number $ws7
      bindsym $mod+Shift+8 move container to workspace number $ws8
      bindsym $mod+Shift+9 move container to workspace number $ws9
      bindsym $mod+Shift+0 move container to workspace number $ws10

      #----------------------------------------------------------------------
      # Resize Mode
      #----------------------------------------------------------------------
      set $mode_resize # Resize / Move

      # This mode will make it easier to resize and move workspaces without
      # having to bind a bunch of obscure bindings.
      mode "$mode_resize" {
              # These bindings trigger as soon as you enter the resize mode

              # Focus parent and child
              bindsym a focus parent
              bindsym $mod+a focus parent
              bindsym c focus child
              bindsym $mod+c focus child

              # Move containers
              bindsym 1 move container to workspace number $ws1; workspace number $ws1
              bindsym 2 move container to workspace number $ws2; workspace number $ws2
              bindsym 3 move container to workspace number $ws3; workspace number $ws3
              bindsym 4 move container to workspace number $ws4; workspace number $ws4
              bindsym 5 move container to workspace number $ws5; workspace number $ws5
              bindsym 6 move container to workspace number $ws6; workspace number $ws6
              bindsym 7 move container to workspace number $ws7; workspace number $ws7
              bindsym 8 move container to workspace number $ws8; workspace number $ws8
              bindsym 9 move container to workspace number $ws9; workspace number $ws9
              bindsym 0 move container to workspace number $ws10; workspace number $ws10

              # Pressing left will shrink the window’s width.
              # Pressing right will grow the window’s width.
              # Pressing up will shrink the window’s height.
              # Pressing down will grow the window’s height.
              bindsym h resize shrink width 10 px or 10 ppt
              bindsym j resize grow height 10 px or 10 ppt
              bindsym k resize shrink height 10 px or 10 ppt
              bindsym l resize grow width 10 px or 10 ppt

              # back to normal: Enter or Escape or $mod+r
              bindsym Return mode "default"
              bindsym Escape mode "default"
              bindsym $mod+r mode "default"
      }

      bindsym $mod+r mode "$mode_resize"

      #----------------------------------------------------------------------
      # System Mode
      #----------------------------------------------------------------------
      # shutdown / restart / suspend...
      set $mode_system System (e) logout, (r) reboot, (Ctrl+s) shutdown

      mode "$mode_system" {
          bindsym e exec --no-startup-id i3-msg exit, mode "default"
          bindsym r exec --no-startup-id systemctl reboot, mode "default"
          bindsym Ctrl+s exec --no-startup-id systemctl poweroff -i, mode "default"

          # back to normal: Enter or Escape
          bindsym Return mode "default"
          bindsym Escape mode "default"
      }

      exec --no-startup-id gxkb
      bindsym $mod+BackSpace mode "$mode_system"
    '';
  };
}
