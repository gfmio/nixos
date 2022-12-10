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
    hardware.pulseaudio = {
      enable = true;
      # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
      # Only the full build has Bluetooth support, so it must be selected here.
      package = pkgs.pulseaudioFull;
    };
  };
}
