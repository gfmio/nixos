#
# netdata settings
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.netdata;
in {
  imports = [ ];

  options = {
    modules = {
      netdata = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Monitoring
    services.netdata = {
      enable = true;
      config = {
        global = {
          "default port" = "19999";
          "bind to" = "127.0.0.1";
        };
      };
    };
  };
}
