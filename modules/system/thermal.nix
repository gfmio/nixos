#
# thermal settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.thermal;
in
{
  imports = [];

  options = {
    modules = {
      thermal = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Thermals and cooling
    services.thermald.enable = true;
  };
}
