{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sway;

  commonOptions = import ./i3+sway.nix {
    inherit lib pkgs;
    terminal = "kitty";
    i3 = false;
    menu = "${pkgs.dmenu}/bin/dmenu_run";
    lockCommand =
      "swaylock --ignore-empty-password --show-failed-attempts --image $HOME/.background-image -t";
  };

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
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      # extraOptions = [ "--verbose" "--debug" "--unsupported-gpu" ];
      extraOptions = [ "--verbose" "--debug" ];
      config = mkMerge [
        commonOptions.config
        { output = { "*" = { bg = "~/.background-image fill"; }; }; }
      ];
    };

    # environment.systemPackages = with pkgs; [
    #   alacritty # gpu accelerated terminal
    #   sway
    #   dbus-sway-environment
    #   configure-gtk
    #   wayland
    #   glib # gsettings
    #   dracula-theme # gtk theme
    #   gnome3.adwaita-icon-theme  # default gnome cursors
    #   swaylock
    #   swayidle
    #   grim # screenshot functionality
    #   slurp # screenshot functionality
    #   wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    #   bemenu # wayland clone of dmenu
    #   mako # notification system developed by swaywm maintainer
    # ];

    # services.pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   pulse.enable = true;
    # };

    # enable sway window manager
    # programs.sway = {
    #   enable = true;
    #   wrapperFeatures.gtk = true;
    #   # extraOptions = [ "--verbose" "--debug" "--unsupported-gpu" ];
    #   extraOptions = [ "--verbose" "--debug" ];
    #   config = mkMerge [
    #     commonOptions.config
    #     { output = { "*" = { bg = "~/.background-image fill"; }; }; }
    #   ];
    # };

    home.packages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      brightnessctl
      xwayland
    ];
  };

  #   # startup = [
  #   #   { command = "$HOME/.screenlayout/desk.sh"; }
  #   #   { command = "${pkgs.feh}/bin/feh --bg-scale $HOME/.background-image"; }
  #   #   # Start XDG autostart .desktop files using dex. See also
  #   #   # https://wiki.archlinux.org/index.php/XDG_Autostart
  #   #   { command = "${pkgs.dex}/bin/dex--autostart --environment i3"; }
  #   #   # TODO: fix picom
  #   #   # { command = ''${pkgs.picom}/bin/picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"''; notification = false; }
  #   # ];
  #   # extraSessionCommands = ''
  #   #
  #   #   ${pkgs.dunst}/bin/dunst &
  #   #   ${optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
  #   #   ${optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
  #   # '';
  # };

}
