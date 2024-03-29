#
# podman nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.podman;
in {
  imports = [ ];

  options = {
    modules = {
      podman = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        dockerCompat = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: Fix infinite recursion
    # modules.docker = mkIf cfg.dockerCompat {
    #   enable = false;
    # };
    virtualisation.podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = cfg.dockerCompat;
    };
  };
}
