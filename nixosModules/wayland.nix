#
# wayland nixos module
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.wayland;
in {
  imports = [ ];

  options = {
    modules = {
      wayland = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
    programs.xwayland.enable = true;
  };
}
