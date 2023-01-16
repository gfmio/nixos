#
# tor settings
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.tor;
in {
  imports = [ ];

  options = {
    modules = {
      tor = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Tor + Privoxy

    services.privoxy.enable = true;

    services.tor = {
      enable = true;
      client = {
        enable = true;
        privoxy.enable = true;
      };
      tsocks.enable = true;
    };
  };
}
