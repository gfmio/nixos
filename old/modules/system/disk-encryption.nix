#
# disk encription settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.diskEncryption;
in
{
  imports = [];

  options = {
    modules = {
      diskEncryption = {
        enable = mkOption { type = types.bool; default = false; };
        device = mkOption { type = types.str; default = null; };
      };
    };
  };

  config = mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.initrd.luks.devices = {
      root = {
        device = cfg.device;
        preLVM = true;
      };
    };
  };
}
