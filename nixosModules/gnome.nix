#
# gnome nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.gnome;
in {
  imports = [ ];

  options = {
    modules = {
      gnome = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs.gnome3; [
      epiphany
      # evolution
      gnome-maps
      accerciser
    ];

    # Enable Chrome GNOME Shell native host connector
    # This is a DBus service allowing to install GNOME Shell extensions from a web browser.
    services.gnome.gnome-browser-connector.enable = true;

    # Enable GNOME Keyring daemon
    services.gnome.gnome-keyring.enable = true;
  };
}
