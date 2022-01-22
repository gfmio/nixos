#
# Boot settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.boot;
in
{
  imports = [];

  options = {
    modules = {
      boot = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.cleanTmpDir = true;
  };
}
