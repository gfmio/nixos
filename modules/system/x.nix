#
# X settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.x;
in
{
  imports = [];

  options = {
    modules = {
      x = {
        enable = mkOption { type = types.bool; default = false; };
        enableLibInput = mkOption { type = types.bool; default = true; };
        enableSynaptics = mkOption { type = types.bool; default = false; };
        xkbLayout = mkOption { type = types.str; default = "us"; };
        xkbOptions = mkOption { type = types.str; default = ""; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = cfg.enableLibInput;

    # Configure keymap in X11
    services.xserver.layout = cfg.xkbLayout;
    services.xserver.xkbOptions = cfg.xkbOptions;

    services.xserver.synaptics.enable = cfg.enableSynaptics;
  };
}
