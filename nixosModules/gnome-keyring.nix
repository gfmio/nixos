#
# gnome-keyring nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.gnome-keyring;
in {
  imports = [ ];

  options = {
    modules = {
      gnome-keyring = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable GNOME Keyring daemon
    services.gnome.gnome-keyring.enable = true;

    programs.seahorse.enable = true;
  };
}
