#
# bluetooth nixos module
#
# TOOD: Add bluetooth tooling
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.bluetooth;
in {
  imports = [ ];

  options = {
    modules = {
      bluetooth = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        powerOnBoot = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Bluetooth
    # https://nixos.wiki/wiki/Bluetooth

    hardware.bluetooth = {
      enable = true;
      # Don't power up the default Bluetooth controller on boot
      powerOnBoot = cfg.powerOnBoot;
      settings = {
        General = {
          # Enable support for bluetooth audio
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "bredr";
        };
      };
      # Appears to crash the bluetooth driver?
      disabledPlugins = ["sap"];
    };

    services.blueman.enable = true;
  };
}
