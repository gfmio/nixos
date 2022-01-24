#
# redshift settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.redshift;
in
{
  imports = [];

  options = {
    modules = {
      redshift = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Redshift
    redshift = {
      enable = true;
      latitude = "51.5072";
      longitude = "0.1276";
    };
  };
}
