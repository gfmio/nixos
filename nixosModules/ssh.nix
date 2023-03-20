#
# SSH nixos module
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
        openPort = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = mkDefault (if cfg.permitRootLogin then "yes" else "no");
        PasswordAuthentication = cfg.passwordAuthentication;
      };
      startWhenNeeded = true;
    };
    networking.firewall = mkIf cfg.openPort { allowedTCPPorts = [ 22 ]; };
  };
}
