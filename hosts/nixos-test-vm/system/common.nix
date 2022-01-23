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
    boot = {
      enable = true;
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
    mtr = {
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
    fonts = {
      enable = true;
    };
    packages = {
      enable = true;
    };
  };
}
