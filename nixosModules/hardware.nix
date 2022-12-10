# Hardware settings
#

{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.hardware;

in {
  imports = [ ];

  options = {
    modules = {
      hardware = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];

    # Enable all the firmware
    hardware.enableAllFirmware = true;
    # Enable all the firmware with a license allowing redistribution. (i.e. free firmware and firmware-linux-nonfree)
    hardware.enableRedistributableFirmware = true;

    # A DBus service that allows applications to update firmware
    services.fwupd.enable = true;
  };
}
