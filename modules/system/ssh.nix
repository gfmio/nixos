#
# SSH settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.ssh;
in
{
  imports = [];

  options = {
    modules = {
      ssh = {
        enable = mkOption { type = types.bool; default = false; };
        permitRootLogin = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
    services.openssh.permitRootLogin = cfg.permitRootLogin;
  };
}
