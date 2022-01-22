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
        name = mkOption { type = types.string; default = "Frédérique Mittelstaedt"; };
        email = mkOption { type = types.string; };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
    };
  };
}
