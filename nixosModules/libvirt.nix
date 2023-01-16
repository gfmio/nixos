#
# libvirt settings
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.libvirt;
in {
  imports = [ ];

  options = {
    modules = {
      libvirt = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Libvirtd / QEMU
    virtualisation.libvirtd.enable = true;
  };
}
