{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.x;
in
{
  imports = [];

  options = {
    modules = {
      x = {
        enable = mkOption { type = types.bool; default = false; };
        scale = mkOption { type = types.float; default = 1; };
      };
    };
  };

  config = mkIf cfg.enable {
    xresources.properties = {
      "Xft.dpi" = builtins.floor (96 * cfg.scale);
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };

    xsession.enable = true;

    xsession.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = builtins.floor (32 * cfg.scale);
    };
  };
}
