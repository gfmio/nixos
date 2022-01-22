{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
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
        terminal = "kitty";
      };
    };
  };
}
