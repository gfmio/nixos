{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
  i3cfg = config.xsession.windowManager.i3;
  super = "Mod4";
  alt = "Mod1";
  mod = "Mod4";
  ctrl = "Ctrl";
  systemMode = "L: lock · O: logout · S: suspend · R: reboot · P: poweroff";
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
  lockCommand = "i3lock --ignore-empty-password --show-failed-attempts --image $HOME/.background-image -t";
in
{
  imports = [];

  options = {
    modules = {
      i3 = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # xsession.windowManager.command = "i3";
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;

        fonts = {
          names = ["Hack, FontAwesome 6"];
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
        menu = "${pkgs.dmenu}/bin/dmenu_run";

        colors = {
          focused = {
            border = "$urchin";
            background = "$urchin";
            text = "$beluga";
            indicator = "$urchin";
            childBorder = "$urchin";
          };
          focusedInactive = {
            border = "$narwhal";
            background = "$narwhal";
            text = "$seal";
            indicator = "$narwhal";
            childBorder = "$narwhal";
          };
          unfocused = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
            indicator = "#292d2e";
            childBorder = "#222222";
          };
          urgent = {
            border = "$orangeRed";
            background = "$orangeRed";
            text = "$beluga";
            indicator = "$urchin";
            childBorder = "$urchin";
          };
          placeholder = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#0c0c0c";
          };
          background = "$squidInk";
        };

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
          "${mod}+Return" = "exec ${i3cfg.config.terminal}";

          # Kill focused window
          "${mod}+Shift+q" = "kill";

          # Start your launcher
          "${mod}+d" = "exec ${i3cfg.config.menu}";

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
          "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

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
          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
          "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set -e +10%";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set -e 10%-";
          # "XF86MonBrightnessUp" = "exec /usr/bin/xbacklight -inc 10";
          # "XF86MonBrightnessDown" = "exec /usr/bin/xbacklight -dec 10";
        };
        # Status Bar:
        bars = [{
          position = "top";
          fonts = {
            names = ["Hack, FontAwesome 6"];
            size = 8.0;
          };
          workspaceNumbers = false;
          # When the statusCommand prints a new line to stdout, i3-bar updates.
          statusCommand = "i3status";
          # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          trayOutput = "primary";
          colors = {
            background = "$squidInk";
            statusline = "$dugong";
            separator = "$dugong";

            focusedBackground = "$squidInk";
            focusedStatusline = "$beluga";
            focusedSeparator = "$beluga";

            focusedWorkspace = {
              border = "$orangeRed";
              background = "$orangeRed";
              text = "$beluga";
            };
            activeWorkspace = {
              border = "$orangeRed";
              background = "$orangeRed";
              text = "$squidInk";
            };
            inactiveWorkspace = {
              border = "$urchin";
              background = "$urchin";
              text = "$seal";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
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
            "Escape" = "default";
          };
          "${systemMode}" = {
            # set $mode_system    [L]OCK       LOG[O]UT       [S]USPEND       [R]EBOOT       [P]OWEROFF
            "l" = ''exec --no-startup-id "\
              ${lockCommand}"; \
              mode "default"
            '';
            "o" = ''exec --no-startup-id "\
              i3-msg exit"; \
              mode "default"
            '';
            "s" = ''exec --no-startup-id "\
              ${lockCommand} && systemctl suspend"; \
              mode "default"
            '';
            "r" = ''exec --no-startup-id "\
              systemctl reboot"; \
              mode "default"
            '';
            "p" = ''exec --no-startup-id "\
              systemctl poweroff"; \
              mode "default"
            '';
            # Return to default mode
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };
        startup = [
          { command = "$HOME/.screenlayout/desk.sh"; notification = false; }
          { command = "${pkgs.feh}/bin/feh --bg-scale $HOME/.background-image"; notification = false; }
          # Start XDG autostart .desktop files using dex. See also
          # https://wiki.archlinux.org/index.php/XDG_Autostart
          { command = "${pkgs.dex}/bin/dex--autostart --environment i3"; notification = false; }
          # TODO: fix picom
          # { command = ''${pkgs.picom}/bin/picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"''; notification = false; }
        ];
        # extraSessionCommands = ''
        #
        #   ${pkgs.dunst}/bin/dunst &
        #   ${optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
        #   ${optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
        # '';
      };
      extraConfig = ''
      #
      ### Variables
      #

      # Colors
      set $orangeRed #ff4500

      set $beluga #ffffff
      set $dugong #f2f6f7
      set $dolphin #d7dfe2
      set $seal #bbc7cc
      set $narwhal #7a9299
      set $urchin #172e35
      set $squidInk #000000

      set $mango50 #fff8b8
      set $sakura300 #ff99aa
      set $mango500 #ffa800
      set $mint500 #00ccc0
      set $alien900 #02315c
      '';

    # #
    # ### Autostart
    # #

    # exec --no-startup-id dex --autostart --environment i3

    # exec --no-startup-id feh --bg-scale "$HOME/.background-image"

    # # The combination of xss-lock, nm-applet and pactl is a popular choice, so
    # # they are included here as an example. Modify as you see fit.

    # # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
    # # screen before suspend. Use loginctl lock-session to lock your screen.
    # exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

    # # NetworkManager is the most popular way to manage wireless networks on Linux,
    # # and nm-applet is a desktop environment-independent system tray GUI for it.
    # exec --no-startup-id nm-applet

    # # exec /usr/libexec/gnome-settings-daemon

    # # exec --no-startup-id xcalib -d :0 ~/.icc/6500.icm

    # # exec --no-startup-id xrdb -load ~/.Xresources
    };
  };
}
