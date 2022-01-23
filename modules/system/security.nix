#
# Security settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.security;
in
{
  imports = [];

  options = {
    modules = {
      security = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Disable sudo password for the wheel group
    security.sudo.wheelNeedsPassword = false;

    security.apparmor.enable = true;
  };
}
