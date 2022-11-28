#
# i3 settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
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
    services.xserver.desktopManager.xterm.enable = false;

    services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        arandr
        dex
        xss-lock
      ];
    };
  };
}
