#
# gpg home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.gpg;
in {
  imports = [ ];

  options = {
    modules = {
      gpg = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        enableSSH = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = cfg.enableSSH;
    };
  };
}
