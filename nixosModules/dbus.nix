#
# dbus nixos module
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.dbus;
in {
  imports = [ ];

  options = {
    modules = {
      dbus = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.dbus.enable = true;
  };
}
