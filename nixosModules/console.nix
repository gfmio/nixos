# console settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.console;
in {
  imports = [ ];

  options = {
    modules = {
      console = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        font = mkOption {
          type = types.str;
          default = "Lat2-Terminus16";
        };
        # TODO: Make colors configurable
        # colors = {
        #   type = types.str;
        #   default = "us";
        # };
      };
    };
  };

  config = mkIf cfg.enable {
    console = {
      font = cfg.font;
      # font = "latarcyrheb-sun32"; # Big console font for HiDPI
      # keyMap is set in i18n
      # keyMap = cfg.keyMap;
      earlySetup = true;
      # useXkbConfig = true;
      colors = [
        "111111"
        "ff4136"
        "3D9970"
        "ffdc00"
        "0074d9"
        "f012be"
        "39cccc"
        "dddddd"
        "aaaaaa"
        "ff4136"
        "01ff70"
        "ffdc00"
        "7fdbff"
        "f012be"
        "39cccc"
        "ffffff"
      ];
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
