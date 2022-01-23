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
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Configure keymap in X11
    # services.xserver.layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";
  };
}
