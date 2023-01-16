#
# networking home module
#
# TODO: Investigate if this is truly needed
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.networking;
in {
  imports = [ ];

  options = {
    modules = {
      networking = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        enableNetworkManagerApplet = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.network-manager-applet.enable = cfg.enableNetworkManagerApplet;
  };
}
