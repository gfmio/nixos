#
# syncthing nixos module
#
# TODO: Test and customize
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.syncthing;
in {
  imports = [ ];

  options = {
    modules = {
      syncthing = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      useInotify = true;
      all_proxy = null;
      dataDir = "/home/gfmio/.syncthing";
      user = "gfmio";
    };
  };
}
