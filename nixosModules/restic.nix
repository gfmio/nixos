{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.restic;
in {
  imports = [ ];

  options = {
    modules = {
      restic = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: Set this up properly
    # https://francis.begyn.be/blog/nixos-restic-backups
    services.restic.backups.name = {
      passwordFile = "/etc/nixos/secrets/restic-password";
      paths = [ "/home/gfmio" ];
      user = "gfmio";
      # initializes the repo, don't set if you want manual control
      initialize = true;
      repository = "rclone:gdrive:/backups";
      timerConfig = { OnCalendar = "12:30"; };
    };
  };
}
