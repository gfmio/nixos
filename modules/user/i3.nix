{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
  super = "Mod1";
  alt = "Mod4";
  mod = "Mod4";
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
          names = ["Hack, DejaVu Sans Mono, FontAwesome 6"];
          size = 8.0;
        };
        terminal = "kitty";
        keybindings = {};
        bars = [];
        # bars = [
        #   {
        #     position = "top";
        #     statusCommand = "i3status";
        #     # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        #   }
        # ];
      };
      extraConfig = ''
      # i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!
#
# This config file uses keycodes (bindsym) and was written for the QWERTY
# layout.
#
# To get a config file with the same key positions, but for your current
# layout, use the i3-config-wizard
#

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

    # Logo key. Use Mod1 for Alt.
    set $mod Mod4
    # set $mod Mod1
    set $alt Mod1
    set $sup Mod4

    # Your preferred terminal emulator
    set $term kitty

    # Your preferred application launcher
    # Note: pass the final command to i3-msg so that the resulting window can be opened
    # on the original workspace that the command was run on.
    set $menu dmenu_path | dmenu | xargs i3-msg exec --
    # start dmenu (a program launcher)
    # bindsym $mod+d exec --no-startup-id dmenu_run
    # A more modern dmenu replacement is rofi:
    # bindsym $mod+d exec "rofi -modi drun,run -show drun"
    # There also is i3-dmenu-desktop which only displays applications shipping a
    # .desktop file. It is a wrapper around dmenu, so you need that installed.
    # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

#
### Theme
#

    # Font for window titles. Will also be used by the bar unless a different font
    # is used in the bar {} block below.
    font pango:monospace 8

    # This font is widely installed, provides lots of unicode glyphs, right-to-left
    # text rendering and scalability on retina/hidpi displays (thanks to pango).
    #font pango:DejaVu Sans Mono 8

    # class                 border  backgr. text    indica. child_border
    client.focused          $urchin $urchin $beluga $urchin $urchin
    client.focused_inactive $narwhal $narwhal $seal $narwhal $narwhal
    client.unfocused        #333333 #222222 #888888 #292d2e #222222
    client.urgent           $orangeRed $orangeRed $beluga $urchin $urchin
    client.placeholder      #000000 #0c0c0c #ffffff #000000 #0c0c0c

    client.background       $squidInk

    # Window borders

    new_window          pixel 0
    new_float           pixel 3
    hide_edge_borders   smart
    bindsym $mod+b border toggle

    # Auto floating for dialog windows

    for_window [window_role="pop-up"] floating enable
    for_window [window_role="task_dialog"] floating enable
    for_window [title="Preferences$"] floating enable
    for_window [class="(?i)mplayer"] floating enable

#
### Key bindings
#

#
# Basics:
#

    # Start a terminal
    bindsym $mod+Return exec $term

    # Kill focused window
    bindsym $mod+Shift+q kill

    # Start your launcher
    bindsym $mod+d exec $menu

    # Drag floating windows by holding down $mod and left mouse button.
    # Resize them with right mouse button + $mod.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier $mod

    # use Mouse+$mod to drag floating windows to their wanted position

    # Reload the configuration file
    bindsym $mod+Shift+c reload

    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart

    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

#
# Moving around:
#

    # Move your focus around
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # Move the focused window with the same, but add Shift
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

#
# Moving around:
#

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

#
# Layout stuff:
#

    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    bindsym $mod+h splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym $mod+space focus mode_toggle

    # Move focus to the parent container
    bindsym $mod+a focus parent

    # focus the child container
    bindsym $mod+Shift+a focus child

#
# Scratchpad:
#

    # i3 has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym $mod+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym $mod+minus scratchpad show

#
# Resizing containers:
#

mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"

#
### System mode
#

set $mode_system    [L]OCK       LOG[O]UT       [S]USPEND       [R]EBOOT       [P]OWEROFF
bindsym $alt+Delete mode "$mode_system"
bindsym Ctrl+$alt+BackSpace mode "$mode_system"
mode "$mode_system" {
  bindsym l exec --no-startup-id "\
    i3lock --ignore-empty-password --show-failed-attempts --image /home/gfmio/Pictures/wallpaper.png"; \
    mode "default"
  bindsym o exec --no-startup-id "\
    i3-msg exit"; \
    mode "default"
  bindsym s exec --no-startup-id "\
    i3lock --ignore-empty-password --show-failed-attempts --image /home/gfmio/Pictures/wallpaper.png && systemctl suspend"; \
    mode "default"
  bindsym r exec --no-startup-id "\
    systemctl reboot"; \
    mode "default"
  bindsym p exec --no-startup-id "\
    systemctl poweroff"; \
    mode "default"

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

#
# Status Bar:
#
# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)

bar {
    position top
    font pango:Hack, Font Awesome 5 Free 8
    separator_symbol "·"
    strip_workspace_numbers yes
    status_command i3status
    tray_output primary

    # When the status_command prints a new line to stdout, i3-bar updates.
    # The default just shows the current date and time.
    # status_command while date +'%Y-%m-%d %l:%M:%S %p'; do sleep 1; done
    status_command i3status

    colors {
        background $squidInk
        statusline $dugong
        separator $dugong

        focused_background $squidInk
        focused_statusline $beluga
        focused_separator $beluga

        focused_workspace $orangeRed $orangeRed $beluga
        active_workspace $orangeRed $orangeRed $squidInk
        inactive_workspace $urchin $urchin $seal

        urgent_workspace   #2f343a #900000 #ffffff
        binding_mode       #2f343a #900000 #ffffff

    }
}

#
### Other keyboard shortcuts
#

# Use pactl to adjust volume in PulseAudio.
set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

bindsym XF86MonBrightnessUp exec brightnessctl -d intel_backlight set -e +10%
bindsym XF86MonBrightnessDown exec brightnessctl -d intel_backlight set -e 10%-

# bindsym XF86MonBrightnessUp exec /usr/bin/xbacklight -inc 10
# bindsym XF86MonBrightnessDown exec /usr/bin/xbacklight -dec 5

#
### Autostart
#

# Start XDG autostart .desktop files using dex. See also
# https://wiki.archlinux.org/index.php/XDG_Autostart
exec --no-startup-id dex --autostart --environment i3

# exec --no-startup-id picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"

exec --no-startup-id feh --bg-scale "/home/gfmio/Pictures/wallpaper.png"

# The combination of xss-lock, nm-applet and pactl is a popular choice, so
# they are included here as an example. Modify as you see fit.

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

# NetworkManager is the most popular way to manage wireless networks on Linux,
# and nm-applet is a desktop environment-independent system tray GUI for it.
exec --no-startup-id nm-applet

# exec /usr/libexec/gnome-settings-daemon

# exec --no-startup-id xcalib -d :0 ~/.icc/6500.icm

# exec --no-startup-id xrdb -load ~/.Xresources
      '';
    };
  };
}
