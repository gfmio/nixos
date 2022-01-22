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

  modules.x.enable = true;
  modules.x.scale = 2.0;

  modules.i3.enable = true;

  modules.chromium.enable = true;

  modules.firefox.enable = true;

  modules.vscode.enable = true;

  modules.sublime.enable = true;

  modules.ssh.enable = true;

  modules.git.enable = true;
  modules.git.email = "git@gfm.io";

  modules.zsh.enable = true;

  modules.htop.enable = true;
}
