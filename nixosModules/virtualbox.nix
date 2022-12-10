# virtualbox settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.virtualbox;
in {
  imports = [ ];

  options = {
    modules = {
      virtualbox = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Install VB
    virtualisation.virtualbox.host.enable = true;
  };
}
