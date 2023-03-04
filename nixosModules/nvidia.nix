#
# nvidia nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.nvidia;
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  imports = [ ];

  options = {
    modules = {
      hardware = {
        nvidia = {
          enable = mkOption {
            type = types.bool;
            default = false;
          };
          setKernelParams = mkOption {
            type = types.bool;
            default = true;
          };
          blacklistNouveau = mkOption {
            type = types.bool;
            default = true;
          };
          setAvailableKernelModules = mkOption {
            type = types.bool;
            default = true;
          };
          enablePrime = mkOption {
            type = types.bool;
            default = false;
          };
          primeMode = mkOption { type = types.enum [ "offload" "sync" ]; };
          intelBusId = mkOption {
            type = types.str;
            default = "";
          };
          nvidiaBusId = mkOption {
            type = types.str;
            default = "";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Boot
    boot.kernelParams = mkIf cfg.setKernelParams [ "nvidia-drm.modeset=1" ];
    boot.blacklistedKernelModules = mkIf cfg.blacklistNouveau [ "nouveau" ];
    boot.initrd.availableKernelModules = mkIf cfg.setAvailableKernelModules [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    # Drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.modesetting.enable = true;

    hardware.nvidia.open = false;

    hardware.opengl = {
      extraPackages = with pkgs; [
        mpi
        linuxPackages.nvidia_x11
        # can't remember which is needed:
        # cudatoolkit
        # cudatoolkit.lib
      ];
    };

    # GDM
    services.xserver.displayManager.gdm.wayland = true;

    # Prime
    environment.systemPackages =
      mkIf (cfg.enablePrime && (cfg.primeMode == "offload")) [ nvidia-offload ];
    hardware.nvidia.prime = mkIf cfg.enablePrime {
      offload.enable = (cfg.primeMode == "offload");
      sync.enable = (cfg.primeMode == "sync");

      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      # intelBusId = "PCI:0:2:0";
      intelBusId = cfg.intelBusId;

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      # nvidiaBusId = "PCI:1:0:0";
      nvidiaBusId = cfg.nvidiaBusId;
    };
  };
}
