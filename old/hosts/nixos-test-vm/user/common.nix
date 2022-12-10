{ config, lib, pkgs, ... }:

{
  #
  # Home manager
  #

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gfmio";
  home.homeDirectory = "/home/gfmio";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  #
  # Modules
  #

  modules = {
    x = {
      enable = true;
      scale = 2.0;
    };
    i3 = {
      enable = true;
    };
    i3status = {
      enable = true;
      ipv6 = false;
      wireless = false;
      battery = false;
    };
    chromium = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    vscode = {
      enable = true;
    };
    sublime = {
      enable = true;
    };
    ssh = {
      enable = true;
    };
    git = {
      enable = true;
      email =  "git@gfm.io";
    };
    zsh = {
      enable = true;
    };
    htop = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    kitty = {
      enable = true;
    };
    alacritty = {
      enable = true;
    };
    picom = {
      enable = true;
    };
    networking = {
      enable = true;
      enableNetworkManagerApplet = false;
    };
    gpg = {
      enable = true;
    };
    gnome-passwordsafe = {
      enable = true;
    };
    sway = {
      enable = false;
    };
    gnome-disk-utility = {
      enable = true;
    };
  };
}
