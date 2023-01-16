#
# xrdp nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.xrdp;
in {
  imports = [ ];

  options = {
    modules = {
      xrdp = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        defaultWindowManager = mkOption {
          type = types.str;
          default = "";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      defaultWindowManager = cfg.defaultWindowManager;
    };
    networking.firewall.allowedTCPPorts = [ 3389 ];
  };
}
