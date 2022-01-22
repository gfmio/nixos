#
# Timezone settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.time;
in
{
  imports = [];

  options = {
    modules = {
      time = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/London";

    # Use the systemd-timesyncd SNTP client to sync the system clock (enabled by default)
    services.timesyncd.enable = true;
  };
}
