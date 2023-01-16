#
# X nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.x;
in {
  imports = [ ];

  options = {
    modules = {
      x = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        enableLibInput = mkOption {
          type = types.bool;
          default = true;
        };
        enableSynaptics = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = cfg.enableLibInput;

    services.xserver.synaptics.enable = cfg.enableSynaptics;

    services.xserver.desktopManager.wallpaper.combineScreens = false;
    services.xserver.desktopManager.wallpaper.mode = "fill";
  };
}
