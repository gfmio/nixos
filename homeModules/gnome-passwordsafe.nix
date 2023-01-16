#
# gnome-passwordsafe home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.gnome-passwordsafe;
in {
  imports = [ ];

  options = {
    modules = {
      gnome-passwordsafe = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ gnome-passwordsafe ]; };
}
