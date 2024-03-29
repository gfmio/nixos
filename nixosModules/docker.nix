#
# docker nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.docker;
in {
  imports = [ ];

  options = {
    modules = {
      docker = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: Fix infinite recursion
    # modules.podman.dockerCompat = false;

    virtualisation.docker = {
      enable = true;
      # Run docker system prune -f periodically
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
      # Don't start the service at boot, use systemd socket activation
      enableOnBoot = false;
    };
  };
}
