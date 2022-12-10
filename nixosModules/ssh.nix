# SSH settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.ssh;
in {
  imports = [ ];

  options = {
    modules = {
      ssh = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        permitRootLogin = mkOption {
          type = types.bool;
          default = false;
        };
        passwordAuthentication = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      permitRootLogin = mkDefault (if cfg.permitRootLogin then "yes" else "no");
      startWhenNeeded = true;
      passwordAuthentication = cfg.passwordAuthentication;
    };
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
