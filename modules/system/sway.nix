#
# sway settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sway;
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
    xdg.portal.wlr.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        mako # notification daemon
        alacritty # Alacritty is the default terminal in the config
        dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
        wdisplays
        wl-clipboard
      ];
    };
  };
}
