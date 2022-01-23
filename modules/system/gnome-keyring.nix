#
# gnome-keyring settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.gnome-keyring;
in
{
  imports = [];

  options = {
    modules = {
      gnome-keyring = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable GNOME Keyring daemon
    services.gnome3.gnome-keyring.enable = true;
  };
}
