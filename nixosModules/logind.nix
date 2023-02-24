#
# logind nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.logind;
in
{
  imports = [];

  options = {
    modules = {
      logind = {
        enable = mkOption { type = types.bool; default = false; };
        powerKeyAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "poweroff"; };
        suspendKeyAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "suspend"; };
        hibernateKeyAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "hibernate"; };
        lidSwitchAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "suspend"; };
        lidSwitchDockedAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "ignore"; };
        lidSwitchExternalPowerAction = mkOption { type = types.enum [ "poweroff" "suspend" "hibernate" "ignore" ]; default = "ignore"; };
      };
    };
  };

  config = mkIf cfg.enable {
    services.logind.extraConfig = ''
    # Triggered when the power key/button is pressed.
    HandlePowerKey=${cfg.powerKeyAction}
    # Triggered when the suspend key/button is pressed.
    HandleSuspendKey=${cfg.suspendKeyAction}
    # Triggered when the hibernate key/button is pressed.
    HandleHibernateKey=${cfg.hibernateKeyAction}
    # Triggered when the lid is closed, except in the cases below.
    HandleLidSwitch=${cfg.lidSwitchAction}
    # Triggered when the lid is closed if the system is inserted in a docking station, or more than one display is connected.
    HandleLidSwitchDocked=${cfg.lidSwitchDockedAction}
    # Triggered when the lid is closed if the system is connected to external power.
    HandleLidSwitchExternalPower=${cfg.lidSwitchExternalPowerAction}
    '';
  };
}
