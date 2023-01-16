#
# Misc system settings nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.system;
in {
  imports = [ ];

  options = {
    modules = {
      system = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        fileSystemsToOptimizeForSSD = mkOption {
          type = types.listOf types.str;
          default = [ ];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # No access time and continuous TRIM for SSD
    fileSystems = listToAttrs (map (mountPoint: {
      name = mountPoint;
      value = { options = [ "noatime" "discard" ]; };
    }) cfg.fileSystemsToOptimizeForSSD);
    # fileSystems."/".options = [ "noatime" "discard" ];
    # fileSystems."/home".options = [ "noatime" "discard" ];

    # If non-empty, write log messages to the specified TTY device.
    services.journald.console = "/dev/tty12";

    # Install + setcap
    programs.iftop.enable = true;
    programs.iotop.enable = true;
    programs.mtr.enable = true;

    # Enable entropy daemon which refills /dev/random when low
    services.haveged.enable = true;

    # Periodically update the database of files used by the locate command
    services.locate.enable = true;

    services.udisks2.enable = true;

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media"
    '';
  };
}
