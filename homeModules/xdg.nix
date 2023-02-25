#
# xdg home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.xdg;
in {
  imports = [ ];

  options = {
    modules = {
      xdg = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
      };
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
