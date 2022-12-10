# lxd settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.lxd;
in {
  imports = [ ];

  options = {
    modules = {
      lxd = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Install LXD
    virtualisation.lxd = { enable = true; };
  };
}
