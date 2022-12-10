# User settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.users-defaults;
in {
  imports = [ ];

  options = {
    modules = {
      users-defaults = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Disable mutable users.
    # users.mutableUsers = false;

    # Use zsh by default for all users
    users.defaultUserShell = pkgs.zsh;

    users.users.root.initialPassword = "root";
  };
}
