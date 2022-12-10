{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.zsh;
in
{
  imports = [];

  options = {
    modules = {
      zsh = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    programs.zsh.oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "sudo" "docker" "kubectl" ];
    };
  };
}
