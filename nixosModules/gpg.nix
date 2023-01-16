#
# gpg nixos module
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
        enableSSHSupport = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = cfg.enableSSHSupport;
    };
  };
}
