# dconf settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.dconf;
in {
  imports = [ ];

  options = {
    modules = {
      dconf = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable { programs.dconf.enable = true; };
}
