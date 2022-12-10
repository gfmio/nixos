# docker settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.podman;
  dockerCfg = config.modules.docker;
in {
  imports = [ ];

  options = {
    modules = {
      podman = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = !dockerCfg.enable;
    };
  };
}
