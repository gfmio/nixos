#
# Sound settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sound;
in
{
  imports = [];

  options = {
    modules = {
      sound = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
