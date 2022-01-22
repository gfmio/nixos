{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.git;
in
{
  imports = [];

  options = {
    modules = {
      git = {
        enable = mkOption { type = types.bool; default = false; };
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
