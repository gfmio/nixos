#
# sound settings
#
# TODO: Test and customize, in particular pipewire
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sound;
in {
  imports = [ ];

  options = {
    modules = {
      sound = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    sound.enable = true;

    hardware.pulseaudio = {
      enable = false;
      # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
      # Only the full build has Bluetooth support, so it must be selected here.
      package = pkgs.pulseaudioFull;
    };

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack = {
        enable = true;
      };
      pulse = {
        enable = true;
      };
      audio = {
        enable = true;
      };
      wireplumber = {
        enable = true;
      };
    };

    # Enable bluetooth audio support
    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.reconnect-profiles"] = "[ hfp_hf hsp_hs a2dp_sink ]";
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
  };
}
