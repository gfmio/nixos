# clamav settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.clamav;
in {
  imports = [ ];

  options = {
    modules = {
      clamav = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable ClamAV, an open source antivirus engine
    services.clamav.daemon.enable = true;
    # Enable ClamAV freshclam updater.
    services.clamav.updater.enable = true;
  };
}
