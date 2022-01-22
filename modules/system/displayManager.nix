#
# Display manager settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.displayManager;
in
{
  imports = [];

  options = {
    modules = {
      displayManager = {
        enable = mkOption { type = types.bool; default = false; };
        displayManager = mkOption { type = types.enum ["gdm" "lightdm"]; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = cfg.displayManager == "gdm";
    services.xserver.displayManager.lightdm.enable = cfg.displayManager == "lightdm";
  };
}
