#
# Kernel settings
#
# TODO: Check what sysctl settings I want
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.kernel;
in {
  imports = [ ];

  options = {
    modules = {
      kernel = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Use latest kernel
    # boot.kernelPackages will use linuxPackages by default, so no need to define it
    nixpkgs.config.packageOverrides = in_pkgs: {
      linuxPackages = in_pkgs.linuxPackages_latest;
    };

    # Enable Kernel same-page merging
    hardware.ksm.enable = true;

    # Sysctl params
    boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
  };
}
