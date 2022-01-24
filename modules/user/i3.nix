{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
  super = "Mod1";
  alt = "Mod4";
  mod = "Mod4";
in
{
  imports = [];

  options = {
    modules = {
      i3 = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # xsession.windowManager.command = "i3";
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        fonts = {
          names = ["Hack, DejaVu Sans Mono, FontAwesome 6"];
          size = 8.0;
        };
        terminal = "kitty";
        # keybindings = {};
        bars = [
          {
            position = "top";
            statusCommand = "i3status";
            # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          }
        ];
      };
    };
  };
}
