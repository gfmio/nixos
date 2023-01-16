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
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        # Use the systemd-boot EFI boot loader.
        systemd-boot = {
          enable = true;
          # Bigger console font
          consoleMode = "2";
          # Prohibits gaining root access by passing init=/bin/sh as a kernel parameter
          editor = false;
          # Disable memtest86
          memtest86.enable = false;
        };
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };

      # Clean /tmp upon restart
      cleanTmpDir = true;

      # Plymouth boot splash screen
      plymouth = {
        enable = true;
        theme = "breeze";
        # themePackages = with pkgs; [ breeze-plymouth ];
      };
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
    # loader = {
    #   grub = {
    #   enable = true;
    #   version = 2;
    # # Define on which hard drive you want to install Grub.
    #   device = "/dev/sda";
    #   };
    # };

    # swapDevices = [ { device = "/swapfile"; size = 4096; } ];
  };
}
