#
# boot nixos module
#
# TODO: customize further
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.boot;
in {
  imports = [ ];

  options = {
    modules = {
      boot = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        loader = mkOption {
          type = types.enum [ "systemd-boot" "grub" ];
          default = "systemd-boot";
        };
        plymouth = mkOption {
          type = types.bool;
          default = true;
        };
        efiSysMountPoint = mkOption {
          type = types.str;
          default = "/boot/efi";
        };
        growPartition = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = cfg.efiSysMountPoint;
        };
        # Use grub
        grub = {
          enable = (cfg.loader == "grub");
          version = 2;
          efiSupport = true;
          # Define on which hard drive you want to install Grub.
          # device = "/dev/sda";
        };
        # Use the systemd-boot EFI boot loader.
        systemd-boot = {
          enable = (cfg.loader == "systemd-boot");
          # Bigger console font
          consoleMode = "2";
          # Prohibits gaining root access by passing init=/bin/sh as a kernel parameter
          editor = false;
          # Disable memtest86
          memtest86.enable = false;
        };
      };

      # Clean /tmp upon restart
      tmp = {
        cleanOnBoot = true;
      };

      # Plymouth boot splash screen
      plymouth = {
        enable = cfg.plymouth;
        theme = "breeze";
        # themePackages = with pkgs; [ breeze-plymouth ];
      };

      # Automatically grow root partition
      growPartition = cfg.growPartition;
    };

    # # The encrypted disk that should be opened before the root filesystem is mounted
    # boot.initrd.luks.devices = [
    #   {
    #     name = "root";
    #     device = "/dev/nvme0n1p2";
    #     # luksOpen will be attempted before LVM scan
    #     preLVM = true;
    #   }
    # ];

    # # Display ownership notice before LUKS prompt
    # boot.initrd.preLVMCommands = ''
    #   echo '--- OWNERSHIP NOTICE ---'
    #   echo 'This device is property of Frédérique Mittelstaedt.'
    #   echo 'If lost please contact frederique [at] gfm [dot] io'
    #   echo '--- OWNERSHIP NOTICE ---'
    # '';

    # initrd.luks.devices."cryptroot" = {
    #   keyFile = "/dev/sdb";
    #   keyFileSize = 4096;
    # };

    # swapDevices = [ { device = "/swapfile"; size = 4096; } ];
  };
}
