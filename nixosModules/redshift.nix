# redshift settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.redshift;
in {
  imports = [ ];

  options = {
    modules = {
      redshift = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Redshift
    services.redshift = {
      enable = true;
      brightness = {
        # Note the string values below.
        day = "1";
        night = "1";
      };
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
    location = {
      provider = "manual";
      latitude = 51.5072;
      longitude = 0.1276;
    };
  };
}
