#
# sway nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sway;

  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };
in {
  imports = [ ];

  options = {
    modules = {
      sway = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        verbose = mkOption {
          type = types.bool;
          default = true;
        };
        debug = mkOption {
          type = types.bool;
          default = true;
        };
        unsupportedGPU = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty # gpu accelerated terminal
      sway
      dbus-sway-environment
      configure-gtk
      wayland
      xdg-utils # for opening default programs when clicking links
      glib # gsettings
      dracula-theme # gtk theme
      gnome3.adwaita-icon-theme  # default gnome cursors
      swaylock
      swayidle
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      bemenu # wayland clone of dmenu
      mako # notification system developed by swaywm maintainer

      vulkan-tools
      vulkan-extension-layer
      vulkan-validation-layers
    ];

    # environment.variables = {
    #   WLR_NO_HARDWARE_CURSORS = "1";
    # };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # enable sway window manager
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        mako # notification daemon
        alacritty # Alacritty is the default terminal in the config
        dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
        wdisplays
        wl-clipboard
        brightnessctl
      ];
      extraOptions = (
        (if cfg.verbose then ["--verbose"] else []) ++
        (if cfg.debug then ["--debug"] else []) ++
        (if cfg.unsupportedGPU then ["--unsupported-gpu"] else [])
      );
    };

    programs.xwayland.enable = true;

    # May no longer be needed
    nixpkgs.overlays = [
      (self: super: {
        wl-clipboard-x11 = super.stdenv.mkDerivation rec {
          pname = "wl-clipboard-x11";
          version = "5";

          src = super.fetchFromGitHub {
            owner = "brunelli";
            repo = "wl-clipboard-x11";
            rev = "v${version}";
            sha256 = "1y7jv7rps0sdzmm859wn2l8q4pg2x35smcrm7mbfxn5vrga0bslb";
          };

          dontBuild = true;
          dontConfigure = true;
          propagatedBuildInputs = [ super.wl-clipboard ];
          makeFlags = [ "PREFIX=$(out)" ];
        };

        xsel = self.wl-clipboard-x11;
        xclip = self.wl-clipboard-x11;
      })
    ];
  };
}
