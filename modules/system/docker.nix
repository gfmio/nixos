#
# docker settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.docker;
in
{
  imports = [];

  options = {
    modules = {
      docker = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
