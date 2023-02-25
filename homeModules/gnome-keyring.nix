#
# gnome-keyring home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.gnome-keyring;
in
{
  imports = [];

  options = {
    modules = {
      gnome-keyring = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable GNOME Keyring daemon
    services.gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
    home.sessionVariables = {
      "SSH_AUTH_SOCK" = "/run/user/1000/keyring/ssh";
    };
  };
}
