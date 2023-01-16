#
# fiefox home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.firefox;
  nur = import (builtins.fetchTarball
    "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
in {
  imports = [ ];

  options = {
    modules = {
      firefox = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      extensions = with nur.repos.rycee.firefox-addons; [
        # https-everywhere
        privacy-badger
        ublock-origin
      ];
    };
  };
}
