#
# xdg nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.xdg;
in {
  imports = [ ];

  options = {
    modules = {
      xdg = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        wlr = mkOption {
          type = types.bool;
          default = true;
        };
        gtk = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = cfg.wlr;
      # gtk portal needed to make gtk apps happy
      extraPortals = mkIf cfg.gtk [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
