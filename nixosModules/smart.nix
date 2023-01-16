#
# S.M.A.R.T nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.smart;
in {
  imports = [ ];

  options = {
    modules = {
      smart = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Check S.M.A.R.T status of all disks and notify in case of errors
    services.smartd = {
      enable = true;
      # Monitor all devices connected to the machine at the time it's being started
      autodetect = true;
      notifications = {
        x11.enable = if config.services.xserver.enable then true else false;
        wall.enable = true; # send wall notifications to all users
      };
    };
  };
}
