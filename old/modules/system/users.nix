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
    # Disable mutable users.
    # users.mutableUsers = false;

    # Use zsh by default for all users
    users.defaultUserShell = pkgs.zsh;

    users.users.root.initialPassword = "root";

    users.users.gfmio = {
      description = "Frédérique Mittelstaedt";
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "lxd" "libvirtd" "networkmanager" "video" ]; # Enable `sudo` for the user.
      shell = pkgs.zsh;
      #packages = [];
    };
  };
}
