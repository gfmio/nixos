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
        defaultSession = mkOption { type = types.str; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = (cfg.displayManager == "gdm");
    services.xserver.displayManager.lightdm.enable = (cfg.displayManager == "lightdm");
    services.xserver.displayManager.defaultSession = cfg.defaultSession;

    nixpkgs = mkIf (cfg.displayManager == "gdm") {
      overlays = [
        (self: super: {
          gnome3 = super.gnome3.overrideScope' (selfg: superg: {
            gnome-shell = superg.gnome-shell.overrideAttrs (old: {
              buildInputs = (old.buildInputs or []) ++ [
                # CHEEKY WALLPAPER DERIVATION HERE
              ];
              patches = (old.patches or []) ++ [
                (pkgs.substituteAll {
                  backgroundColour = "#d94360";
                  # backgroundPath = wallpaper.gnomeFilePath;
                  backgroundPath = /home/gfmio/.background-image;
                  src = /home/gfmio/.background-image;
                })
              ];
            });
          });
        })
      ];
    };
  };
}
