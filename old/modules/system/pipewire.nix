#
# pipewire settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.pipewire;
in
{
  imports = [];

  options = {
    modules = {
      pipewire = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.pipewire.enable = true;
  };
}
