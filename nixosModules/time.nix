#
# timezone nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.time;
in {
  imports = [ ];

  options = {
    modules = {
      time = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        timeZone = mkOption {
          type = types.str;
          default = "Europe/London";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;

    # Use the systemd-timesyncd SNTP client to sync the system clock (enabled by default)
    services.timesyncd.enable = true;
  };
}
