#
# Misc system settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.system;
in
{
  imports = [];

  options = {
    modules = {
      system = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # No access time and continuous TRIM for SSD
    fileSystems."/".options = [ "noatime" "discard" ];
    fileSystems."/home".options = [ "noatime" "discard" ];

    # If non-empty, write log messages to the specified TTY device.
    services.journald.console = "/dev/tty12";

    # Install + setcap
    programs.iftop.enable = true;
    programs.iotop.enable = true;
    programs.mtr.enable = true;

    # Enable entropy daemon which refills /dev/random when low
    services.haveged.enable = true;
  };
}
