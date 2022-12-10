#
# Printing / CUPS settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.cups;
in
{
  imports = [];

  options = {
    modules = {
      cups = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
