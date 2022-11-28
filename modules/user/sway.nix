{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sway;

  commonOptions = import ./i3+sway.nix {
    inherit lib pkgs;
    terminal = "kitty";
    i3 = false;
    menu = "${pkgs.dmenu}/bin/dmenu_run";
    lockCommand = "swaylock --ignore-empty-password --show-failed-attempts --image $HOME/.background-image -t";
  };
in
{
  imports = [];

  options = {
    modules = {
      sway = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraOptions = [
        "--verbose"
        "--debug"
        "--unsupported-gpu"
      ];
      config = mkMerge [
        commonOptions.config
        {
          output = {
            "*" = { bg = "~/.background-image fill"; };
          };
        }
      ];
        # startup = [
        #   { command = "$HOME/.screenlayout/desk.sh"; }
        #   { command = "${pkgs.feh}/bin/feh --bg-scale $HOME/.background-image"; }
        #   # Start XDG autostart .desktop files using dex. See also
        #   # https://wiki.archlinux.org/index.php/XDG_Autostart
        #   { command = "${pkgs.dex}/bin/dex--autostart --environment i3"; }
        #   # TODO: fix picom
        #   # { command = ''${pkgs.picom}/bin/picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"''; notification = false; }
        # ];
        # extraSessionCommands = ''
        #
        #   ${pkgs.dunst}/bin/dunst &
        #   ${optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
        #   ${optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
        # '';
    };
    home.packages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      brightnessctl
    ];
  };
}
