{ config, lib, pkgs, ... }:

{
  #
  # Core nixos settings
  #

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  #
  # Modules
  #

  modules = {
    hardware = {
      enable = true;
      # Enable nvidia, qemu or neither
      intel = {
        enable = false;
      };
      nvidia = {
        enable = true;
      };
      qemu = {
        enable = false;
      };
    };
    boot = {
      enable = true;
    };
    kernel = {
      enable = true;
    };
    system = {
      enable = true;
    };
    smart = {
      enable = false;
    };
    thermal = {
      enable = false;
    };
    power = {
      enable = false;
    };
    time = {
      enable = true;
    };
    security = {
      enable = true;
    };
    networking = {
      enable = true;
      hostname = "gfmio-nixos";
      # TODO: Ethernet adapters, wireless, firewall
    };
    i18n = {
      enable = true;
    };
    sound = {
      enable = true;
    };
    x = {
      enable = true;
    };
    displayManager = {
      enable = true;
      displayManager = "gdm";
      defaultSession = "none+i3";
    };
    gnome = {
      enable = false;
    };
    sway = {
      enable = false;
    };
    i3 = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
    users = {
      enable = true;
    };
    cups = {
      enable = true;
    };
    ssh = {
      enable = true;
      permitRootLogin = false;
      passwordAuthentication = true;
    };
    gpg = {
      enable = true;
    };
    pipewire = {
      enable = true;
    };
    xrdp = {
      enable = true;
    };
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
    };
    lxd = {
      enable = true;
    };
    libvirt = {
      enable = true;
    };
    virtualbox = {
      enable = true;
    };
    fonts = {
      enable = true;
    };
    packages = {
      enable = true;
    };
    restic = {
      enable = false;
    };
    flatpak = {
      enable = true;
    };
    clamav = {
      enable = false;
    };
    gnome-keyring = {
      enable = true;
    };
    netdata = {
      enable = true;
    };
    bluetooth = {
      enable = false;
    };
    syncthing = {
      enable = false;
    };
    dns = {
      enable = false;
    };
    tor = {
      enable = false;
    };
    redshift = {
      enable = true;
    };
  };
}
