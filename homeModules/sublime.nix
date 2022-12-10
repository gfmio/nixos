{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.sublime;
in {
  imports = [ ];

  options = {
    modules = {
      sublime = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ sublime4 ]; };
}
