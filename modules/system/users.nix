#
# User settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.users;
in
{
  imports = [];

  options = {
    modules = {
      users = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    users.users.root.initialPassword = "root";

    users.users.gfmio = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ]; # Enable `sudo` for the user.
      shell = pkgs.zsh;
    };
  };
}
