#
# GNOME settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.gnome;
in
{
  imports = [];

  options = {
    modules = {
      gnome = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
