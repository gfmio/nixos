#
# qemu nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.hardware.qemu;
in {
  imports = [ ];

  options = {
    modules = {
      hardware = {
        qemu = {
          enable = mkOption {
            type = types.bool;
            default = false;
          };
          enableVideoDrivers = mkOption {
            type = types.bool;
            default = false;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Drivers
    services.xserver.videoDrivers = mkIf cfg.enableVideoDrivers [ "qxl" "modesetting" "fbdev" ];

    # Guest utilities
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
