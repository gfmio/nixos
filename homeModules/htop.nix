#
# htop home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.htop;
in {
  imports = [ ];

  options = {
    modules = {
      htop = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.htop = {
      enable = true;
      # Detailed CPU time (System/IO-Wait/Hard-IRQ/Soft-IRQ/Steal/Guest).
      # detailedCpuTime = true;
    };
  };
}
