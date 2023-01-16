#
# kitty home module
#
# TODO: extract the color config
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.kitty;
in {
  imports = [ ];

  options = {
    modules = {
      kitty = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;

        foreground = "#dddddd";
        background = "#000000";
        background_opacity = "1.0";

        window_padding_width = 0;

        # Black, Gray
        color0 = "#111111";
        color8 = "#aaaaaa";

        # Silver, White
        color7 = "#dddddd";
        color15 = "#ffffff";

        # Red
        color1 = "#ff4136";
        color9 = "#ff4136";

        # Green
        # color2  = "#2ecc40";
        color2 = "#3D9970";
        color10 = "#01ff70";

        # Yellow
        color3 = "#ffdc00";
        color11 = "#ffdc00";

        # Blue
        color4 = "#0074d9";
        color12 = "#7fdbff";

        # Magenta
        color5 = "#f012be";
        color13 = "#f012be";

        # Cyan
        color6 = "#39cccc";
        color14 = "#39cccc";

        mark1_foreground = "black";
        mark1_background = "#98d3cb";

        mark2_foreground = "black";
        mark2_background = "#f2dcd3";

        mark3_foreground = "black";
        mark3_background = "#f274bc";

        # Extra colors
        # navy
        color16 = "#001f3f";
        # aqua
        color17 = "#7fdbff";
        # olive
        color18 = "#3d9970";
        # orange
        color19 = "#ff851b";
        # maroon
        color20 = "#85144b";
        # purple
        color21 = "#b10dc9";
      };
      font = {
        name = "Hack";
        size = 10;
      };
      keybindings = { };
      # environment = {
      #   "LS_COLORS" = "1";
      # };
    };
  };
}
