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
    programs.ssh = {
      enable = true;
    };
  };
}
