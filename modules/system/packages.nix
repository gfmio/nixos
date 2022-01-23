#
# System package settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.packages;
in
{
  imports = [];

  options = {
    modules = {
      packages = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    #
    # System packages
    #

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim
      git
      gitAndTools.diff-so-fancy
      wget
      gcc
      pkg-config
      openssl
      libsecret
      pciutils

      alacritty
      kitty

      gnome3.adwaita-icon-theme
      gnomeExtensions.appindicator
      gnome3.gnome-settings-daemon
      gnome3.nautilus

      remmina
    ];

    #
    # gvfs (for nautlius)
    #

    services.gvfs.enable = true;

    #
    # Make vim the default EDITOR
    #

    environment.variables.EDITOR = "vim";
  };
}
