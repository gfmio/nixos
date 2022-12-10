{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.gnome-disk-utility;
in
{
  imports = [];

  options = {
    modules = {
      gnome-disk-utility = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnome3.gnome-disk-utility ];
  };
}
