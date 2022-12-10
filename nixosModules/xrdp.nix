# xrdp settings
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
      };
    };
  };

  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      # TODO: Make this configurable
      defaultWindowManager = "i3";
    };
    networking.firewall.allowedTCPPorts = [ 3389 ];
  };
}
