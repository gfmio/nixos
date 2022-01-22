#
# qemu settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.qemu;
in
{
  imports = [];

  options = {
    modules = {
      qemu = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Drivers
    services.xserver.videoDrivers = [ "qxl" "modesetting" "fbdev" ];

    # Guest utilities
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
