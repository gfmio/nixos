#
# Intel settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.intel;
in
{
  imports = [];

  options = {
    modules = {
      intel = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # https://wiki.archlinux.org/index.php/Kernel_mode_setting#Early_KMS_start
    boot.initrd.kernelModules = [ "i915" ];
    # Enable framebuffer compression (FBC)
    # can reduce power consumption while reducing memory bandwidth needed for screen refreshes.
    # https://wiki.archlinux.org/index.php/intel_graphics#Framebuffer_compression_(enable_fbc)
    boot.kernelParams = [ "i915.enable_fbc=1" ];

    # Enable microcode updates for Intel CPU
    hardware.cpu.intel.updateMicrocode = true;

    hardware.opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
