{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.ssh;
in
{
  imports = [];

  options = {
    modules = {
      ssh = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
    };
  };
}
