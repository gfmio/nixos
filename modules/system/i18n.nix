#
# i18n / locale settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i18n;
in
{
  imports = [];

  options = {
    modules = {
      i18n = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
    console = {
      font = "Lat2-Terminus16";
      # font = "latarcyrheb-sun32"; # Big console font for HiDPI
      keyMap = "us";
      earlySetup = true;
      # useXkbConfig = true;
      # colors = [];
      # example = [
      #   "002b36" "dc322f" "859900" "b58900"
      #   "268bd2" "d33682" "2aa198" "eee8d5"
      #   "002b36" "cb4b16" "586e75" "657b83"
      #   "839496" "6c71c4" "93a1a1" "fdf6e3"
      # ];
      # description = ''
      #   The 16 colors palette used by the virtual consoles.
      #   Leave empty to use the default colors.
      #   Colors must be in hexadecimal format and listed in
      #   order from color 0 to color 15.
      # '';
    };
  };
}
