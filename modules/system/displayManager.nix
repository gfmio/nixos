#
# Display manager settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.displayManager;
in
{
  imports = [];

  options = {
    modules = {
      displayManager = {
        enable = mkOption { type = types.bool; default = false; };
        displayManager = mkOption { type = types.enum ["gdm" "lightdm"]; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = (cfg.displayManager == "gdm");
    services.xserver.displayManager.lightdm.enable = (cfg.displayManager == "lightdm");

    nixpkgs = mkIf (cfg.displayManager == "gdm") {
      overlays = [
        (self: super: {
          gnome = super.gnome.overrideScope' (selfg: superg: {
            gnome-shell = superg.gnome-shell.overrideAttrs (old: {
              patches = (old.patches or []) ++ [
                (pkgs.substituteAll {
                  src = ./gnome-shell_3.38.3-3ubuntu1_3.38.3-3ubuntu2.patch;
                })
              ];
            });
          });
        })
      ];
    };

    services.xserver.desktopManager.gnome.extraGSettingsOverrides = mkIf (cfg.displayManager == "gdm") ''
    [com.ubuntu.login-screen]
    background-repeat='no-repeat'
    background-size='cover'
    background-color='#777777'
    background-picture-uri='file:///home/gfmio/.background-image.png'
    '';
  };
}
