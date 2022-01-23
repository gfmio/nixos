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
      font = "Lat2-Terminus16";
      # consoleFont = "latarcyrheb-sun32"; # Big console font for HiDPI
      # consoleKeyMap = "fr";
      defaultLocale = "en_US.UTF-8";
    };

    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    # };
  };
}
