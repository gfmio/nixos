#
# Nvidia settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.nvidia;
in
{
  imports = [];

  options = {
    modules = {
      nvidia = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Boot
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.initrd.availableKernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

    # Drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.modesetting.enable = true;

    # GDM
    services.xserver.displayManager.gdm.nvidiaWayland = false;
    services.xserver.displayManager.gdm.wayland = false;
  };
}
