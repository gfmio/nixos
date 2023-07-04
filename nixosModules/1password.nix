#
# 1password nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules._1password;
in {
  imports = [ ];

  options = {
    modules = {
      _1password = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git-credential-1password
    ];
    programs._1password-gui.enable = true;
    programs._1password.enable = true;
  };
}
