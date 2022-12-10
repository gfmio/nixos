# i18n / locale settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.i18n;
in {
  imports = [ ];

  options = {
    modules = {
      i18n = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        locale = mkOption {
          type = types.str;
          default = "en_US.UTF-8";
        };
        xkb = {
          layout = mkOption {
            type = types.str;
            default = "us";
          };
          variant = mkOption {
            type = types.str;
            default = "";
          };
          options = mkOption {
            type = types.str;
            default = "";
          };
        };
        console = {
          keyMap = mkOption {
            type = types.str;
            default = "us";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = {
        LC_ADDRESS = mkDefault cfg.locale;
        LC_IDENTIFICATION = mkDefault cfg.locale;
        LC_MEASUREMENT = mkDefault cfg.locale;
        LC_MONETARY = mkDefault cfg.locale;
        LC_NAME = mkDefault cfg.locale;
        LC_NUMERIC = mkDefault cfg.locale;
        LC_PAPER = mkDefault cfg.locale;
        LC_TELEPHONE = mkDefault cfg.locale;
        LC_TIME = mkDefault cfg.locale;
      };
    };

    # Configure keymap in X11
    services.xserver = {
      layout = cfg.xkb.layout;
      xkbVariant = cfg.xkb.variant;
      xkbOptions = cfg.xkb.options;
    };

    # Configure console keymap
    console.keyMap = cfg.console.keyMap;
  };
}
