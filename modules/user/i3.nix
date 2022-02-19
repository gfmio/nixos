{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;

  commonOptions = import ./i3+sway.nix {
    inherit lib pkgs;
    terminal = "kitty";
    i3 = true;
    menu = "${pkgs.dmenu}/bin/dmenu_run";
    lockCommand = "i3lock --ignore-empty-password --show-failed-attempts --image $HOME/.background-image -t";
  };
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
      config = mkMerge [
        commonOptions.config
        { startup = [
          { command = "$HOME/.screenlayout/desk.sh"; notification = false; }
          { command = "${pkgs.feh}/bin/feh --bg-scale $HOME/.background-image"; notification = false; }
          # Start XDG autostart .desktop files using dex. See also
          # https://wiki.archlinux.org/index.php/XDG_Autostart
          { command = "${pkgs.dex}/bin/dex --autostart --environment i3"; notification = false; }
          # TODO: fix picom
          # { command = ''${pkgs.picom}/bin/picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"''; notification = false; }
        ]; }
      ]
      ;
    # extraSessionCommands = ''
    #
    #   ${pkgs.dunst}/bin/dunst &
    #   ${optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
    #   ${optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
    # '';

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
