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
        { startup = [
            { command = "dbus-sway-environment"; always = true; }
            { command = "configure-gtk"; always = true; }
          ];
          # set $menu bemenu-run
          # bindsym $mod+c exec grim  -g "$(slurp)" /tmp/$(date +'%H:%M:%S.png')
        }
      ];
    };

    nixpkgs.config.chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer --enable-features=UseOzonePlatform --ozone-platform=wayland";

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
