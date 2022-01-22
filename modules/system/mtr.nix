#
# mtr settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.mtr;
in
{
  imports = [];

  options = {
    modules = {
      mtr = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
  };
}
