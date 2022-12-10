# power settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.power;
in {
  imports = [ ];

  options = {
    modules = {
      power = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # This includes support for suspend-to-RAM and powersave features on laptops
    powerManagement.enable = true;
    # Enable powertop auto tuning on startup.
    powerManagement.powertop.enable = false;
    # IDK if TLP is useful/conflicts with powerManagement
    services.tlp.enable = false;
    services.tlp.extraConfig = "USB_AUTOSUSPEND=0";
  };
}
