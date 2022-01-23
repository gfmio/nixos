#
# flatpak settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.flatpak;
in
{
  imports = [];

  options = {
    modules = {
      flatpak = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable Flatpak
    services.flatpak.enable = true;
    # No snap yet: https://github.com/NixOS/nixpkgs/issues/30336
  };
}
