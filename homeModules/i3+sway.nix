{ lib, pkgs, i3 ? false, terminal ? "kitty"
, menu ? "${pkgs.dmenu}/bin/dmenu_run", lockCommand }:

with lib;

let
  super = "Mod4";
  alt = "Mod1";
  mod = "Mod4";
  ctrl = "Ctrl";

  systemMode = "L: lock · O: logout · S: suspend · R: reboot · P: poweroff";

  i3nag = ''
    exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';
  swaynag = ''
    exec "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'"'';
  nag = if i3 then i3nag else swaynag;

  refresh_i3status = "killall -SIGUSR1 i3status";

  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";
in {
  config = {
    modifier = mod;

    fonts = {
      names = [ "Hack, FontAwesome 6" ];
      size = 8.0;
    };

    terminal = "kitty";

    # dmenu_path | dmenu | xargs i3-msg exec --
    # dmenu_run
    # A more modern dmenu replacement is rofi:
    # rofi -modi drun,run -show drun
    # There also is i3-dmenu-desktop which only displays applications shipping a
    # .desktop file. It is a wrapper around dmenu, so you need that installed.
    # i3-dmenu-desktop
    menu = menu;

    # colors = {
    #   focused = {
    #     border = "#ffffff";
    #     background = "#ffffff";
    #     text = "#ffffff";
    #     indicator = "#ffffff";
    #     childBorder = "#ffffff";
    #   };
    #   focusedInactive = {
    #     border = "#ffffff";
    #     background = "#ffffff";
    #     text = "#ffffff";
    #     indicator = "#ffffff";
    #     childBorder = "#ffffff";
    #   };
    #   unfocused = {
    #     border = "#333333";
    #     background = "#222222";
    #     text = "#888888";
    #     indicator = "#292d2e";
    #     childBorder = "#222222";
    #   };
    #   urgent = {
    #     border = "#ffffff";
    #     background = "#ffffff";
    #     text = "#ffffff";
    #     indicator = "#ffffff";
    #     childBorder = "#ffffff";
    #   };
    #   placeholder = {
    #     border = "#000000";
    #     background = "#0c0c0c";
    #     text = "#ffffff";
    #     indicator = "#000000";
    #     childBorder = "#0c0c0c";
    #   };
    #   background = "#ffffff";
    # };

    window = {
      # Window borders
      # new_window          pixel 0
      border = 0;
      titlebar = false;
      hideEdgeBorders = "smart";
    };

    floating = {
      modifier = "${mod}";
      # new_float pixel 3
      border = 3;
      # Auto floating for dialog windows
      criteria = [
        { "window_role" = "pop-up"; }
        { "window_role" = "task_dialog"; }
        { "title" = "Preferences$"; }
        { "class" = "(?i)mplayer"; }
      ];
    };

    keybindings = {
      #
      # Basics:
      #

      # Start a terminal
      "${mod}+Return" = "exec ${terminal}";

      # Kill focused window
      "${mod}+Shift+q" = "kill";

      # Start your launcher
      "${mod}+d" = "exec ${menu}";

      # # Drag floating windows by holding down $mod and left mouse button.
      # # Resize them with right mouse button + $mod.
      # # Despite the name, also works for non-floating windows.
      # # Change normal to inverse to use left mouse button for resizing and right
      # # mouse button for dragging.
      # floating_modifier $mod
      # # use Mouse+$mod to drag floating windows to their wanted position

      # Reload the configuration file
      "${mod}+Shift+c" = "reload";

      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      "${mod}+Shift+r" = "restart";

      # exit i3 (logs you out of your X session)
      "${mod}+Shift+e" = nag;

      #
      # Moving around:
      #

      # Move your focus around
      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      # Move the focused window with the same, but add Shift
      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";

      #
      # Workspaces:
      #

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.

      # switch to workspace
      "${mod}+1" = "workspace number ${ws1}";
      "${mod}+2" = "workspace number ${ws2}";
      "${mod}+3" = "workspace number ${ws3}";
      "${mod}+4" = "workspace number ${ws4}";
      "${mod}+5" = "workspace number ${ws5}";
      "${mod}+6" = "workspace number ${ws6}";
      "${mod}+7" = "workspace number ${ws7}";
      "${mod}+8" = "workspace number ${ws8}";
      "${mod}+9" = "workspace number ${ws9}";
      "${mod}+0" = "workspace number ${ws10}";

      # move focused container to workspace
      "${mod}+Shift+1" = "move container to workspace number ${ws1}";
      "${mod}+Shift+2" = "move container to workspace number ${ws2}";
      "${mod}+Shift+3" = "move container to workspace number ${ws3}";
      "${mod}+Shift+4" = "move container to workspace number ${ws4}";
      "${mod}+Shift+5" = "move container to workspace number ${ws5}";
      "${mod}+Shift+6" = "move container to workspace number ${ws6}";
      "${mod}+Shift+7" = "move container to workspace number ${ws7}";
      "${mod}+Shift+8" = "move container to workspace number ${ws8}";
      "${mod}+Shift+9" = "move container to workspace number ${ws9}";
      "${mod}+Shift+0" = "move container to workspace number ${ws10}";

      #
      # Layout stuff:
      #

      # You can "split" the current object of your focus with
      # $mod+b or $mod+v, for horizontal and vertical splits
      # respectively.
      "${mod}+h" = "splith";
      "${mod}+v" = "splitv";

      # Switch the current container between different layout styles
      "${mod}+s" = "layout stacking";
      "${mod}+w" = "layout tabbed";
      "${mod}+e" = "layout toggle split";

      # Make the current focus fullscreen
      "${mod}+f" = "fullscreen";

      # Toggle the current focus between tiling and floating mode
      "${mod}+Shift+space" = "floating toggle";

      # Swap focus between the tiling area and the floating area
      "${mod}+space" = "focus mode_toggle";

      # Move focus to the parent container
      "${mod}+a" = "focus parent";

      # focus the child container
      "${mod}+Shift+a" = "focus child";

      "${mod}+b" = "border toggle";

      #
      # Scratchpad:
      #

      # i3 has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Move the currently focused window to the scratchpad
      "${mod}+Shift+minus" = "move scratchpad";

      # Show the next scratchpad window or hide the focused scratchpad window.
      # If there are multiple scratchpad windows, this command cycles through them.
      "${mod}+minus" = "scratchpad show";

      #
      # Mode selectors
      #

      "${mod}+r" = "mode resize";
      "${alt}+Delete" = ''mode "${systemMode}"'';
      "${ctrl}+${alt}+BackSpace" = ''mode "${systemMode}"'';

      #
      # Misc
      #

      # Use pactl to adjust volume in PulseAudio.
      "XF86AudioRaiseVolume" =
        "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
      "XF86AudioLowerVolume" =
        "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
      "XF86AudioMute" =
        "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
      "XF86AudioMicMute" =
        "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

      "XF86MonBrightnessUp" =
        "exec ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set -e +10%";
      "XF86MonBrightnessDown" =
        "exec ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set -e 10%-";
      # "XF86MonBrightnessUp" = "exec /usr/bin/xbacklight -inc 10";
      # "XF86MonBrightnessDown" = "exec /usr/bin/xbacklight -dec 10";
    };
    # Status Bar:
    bars = [{
      position = "top";
      fonts = {
        names = [ "Hack, FontAwesome 6" ];
        size = 8.0;
      };
      workspaceNumbers = false;
      # When the statusCommand prints a new line to stdout, i3-bar updates.
      statusCommand = "i3status";
      # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
      trayOutput = "primary";
      # colors = {
      #   background = "#ffffff";
      #   statusline = "#ffffff";
      #   separator = "#ffffff";

      #   focusedBackground = "#ffffff";
      #   focusedStatusline = "#ffffff";
      #   focusedSeparator = "#ffffff";

      #   focusedWorkspace = {
      #     border = "#ffffff";
      #     background = "#ffffff";
      #     text = "#ffffff";
      #   };
      #   activeWorkspace = {
      #     border = "#ffffff";
      #     background = "#ffffff";
      #     text = "#ffffff";
      #   };
      #   inactiveWorkspace = {
      #     border = "#ffffff";
      #     background = "#ffffff";
      #     text = "#ffffff";
      #   };
      #   urgentWorkspace = {
      #     border = "#2f343a";
      #     background = "#900000";
      #     text = "#ffffff";
      #   };
      #   bindingMode = {
      #     border = "#2f343a";
      #     background = "#900000";
      #     text = "#ffffff";
      #   };
      # };
      extraConfig = ''
        separator_symbol ·
      '';
    }];
    modes = {
      resize = {
        # left will shrink the containers width
        "Left" = "resize shrink width 10px";
        # right will grow the containers width
        "Right" = "resize grow width 10px";
        # up will shrink the containers height
        "Up" = "resize shrink height 10px";
        # down will grow the containers height
        "Down" = "resize grow height 10px";

        # Return to default mode
        "Return" = "mode default";
        "Escape" = "mode default";
      };
      "${systemMode}" = {
        # set $mode_system    [L]OCK       LOG[O]UT       [S]USPEND       [R]EBOOT       [P]OWEROFF
        "l" = ''
          exec --no-startup-id "\
                    ${lockCommand}"; \
                    mode "default"
        '';
        "o" = ''
          exec --no-startup-id "\
                    i3-msg exit"; \
                    mode "default"
        '';
        "s" = ''
          exec --no-startup-id "\
                    ${lockCommand} && systemctl suspend"; \
                    mode "default"
        '';
        "r" = ''
          exec --no-startup-id "\
                    systemctl reboot"; \
                    mode "default"
        '';
        "p" = ''
          exec --no-startup-id "\
                    systemctl poweroff"; \
                    mode "default"
        '';
        # Return to default mode
        "Return" = "mode default";
        "Escape" = "mode default";
      };
    };
  };
}
