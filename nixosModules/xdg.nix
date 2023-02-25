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
    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    xdg = {
      autostart = {
        enable = true;
      };
      icons = {
        enable = true;
      };
      menus = {
        enable = true;
      };
      mime = {
        enable = true;
      };
      sounds = {
        enable = true;
      };
      portal = {
        enable = true;
        wlr = {
          enable = cfg.wlr;
        };
        # gtk portal needed to make gtk apps happy
        extraPortals = mkIf cfg.gtk [ pkgs.xdg-desktop-portal-gtk ];
      };
    };
  };
}
