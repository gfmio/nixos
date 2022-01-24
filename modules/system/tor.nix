#
# tor settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.tor;
in
{
  imports = [];

  options = {
    modules = {
      tor = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Tor + Privoxy

    privoxy.enable = true;
    tor = {
      enable = true;
      client = {
        enable = true;
        privoxy.enable = true;
      };
      tsocks.enable = true;
    };
  };
}
