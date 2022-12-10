{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.i3status;
in {
  imports = [ ];

  options = {
    modules = {
      i3status = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        ipv6 = mkOption {
          type = types.bool;
          default = true;
        };
        wireless = mkOption {
          type = types.bool;
          default = true;
        };
        ethernet = mkOption {
          type = types.bool;
          default = true;
        };
        battery = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        interval = 1;
      };
      modules = {
        ipv6 = {
          enable = cfg.ipv6;
          position = 1;
          settings = { };
        };
        "wireless _first_" = {
          enable = cfg.wireless;
          position = 2;
          settings = {
            format_up = "W: (%quality at %essid) %ip";
            format_down = "W: down";
          };
        };
        "ethernet _first_" = {
          enable = cfg.ethernet;
          position = 3;
          settings = {
            format_up = "E: %ip (%speed)";
            format_down = "E: down";
          };
        };
        "battery all" = {
          enable = cfg.battery;
          position = 4;
          settings = { format = "%status %percentage %remaining"; };
        };
        "disk /" = {
          enable = true;
          position = 5;
          settings = { format = "%avail"; };
        };
        "load" = {
          enable = true;
          position = 6;
          settings = { format = "%1min"; };
        };
        "memory" = {
          enable = true;
          position = 7;
          settings = {
            format = "%used | %available";
            threshold_degraded = "1G";
            format_degraded = "MEMORY < %available";
          };
        };
        "volume master" = {
          enable = true;
          position = 8;
          settings = {
            format = "♪: %volume";
            format_muted = "♪: muted (%volume)";
            # device = "pulse"
            device = "default";
            mixer = "Master";
            mixer_idx = 0;
          };
        };
        "tztime PT" = {
          enable = true;
          position = 9;
          settings = {
            format = "PT %H:%M";
            timezone = "US/Pacific";
            hide_if_equals_localtime = false;
          };
        };
        "tztime ET" = {
          enable = true;
          position = 10;
          settings = {
            format = "ET %H:%M";
            timezone = "US/Eastern";
            hide_if_equals_localtime = false;
          };
        };
        "tztime LDN" = {
          enable = true;
          position = 11;
          settings = {
            format = "LDN %H:%M";
            timezone = "Europe/London";
            hide_if_equals_localtime = false;
          };
        };
        "tztime Berlin" = {
          enable = true;
          position = 12;
          settings = {
            format = "BLN %H:%M";
            timezone = "Europe/Berlin";
            hide_if_equals_localtime = false;
          };
        };
        "tztime HK" = {
          enable = true;
          position = 13;
          settings = {
            format = "HK %H:%M";
            timezone = "Asia/Hong_Kong";
            hide_if_equals_localtime = false;
          };
        };
        "tztime Tokyo" = {
          enable = true;
          position = 14;
          settings = {
            format = "TYO %H:%M";
            timezone = "Asia/Tokyo";
            hide_if_equals_localtime = false;
          };
        };
        "tztime local" = {
          enable = true;
          position = 15;
          settings = { format = "%Y-%m-%d %H:%M:%S"; };
        };
      };
    };
  };
}
