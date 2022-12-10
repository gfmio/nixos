# gfmio user settings
#

{ inputs, ... }@flakeContext:
{ system }:
{ config, pkgs, lib, ... }: {
  imports = [
    (inputs.self.homeConfigurations.gfmio {
      lib = lib;
      system = system;
    }).nixosModule
  ];

  options = { };

  config = {
    users.users.gfmio = {
      isNormalUser = true;
      description = "gfmio";
      initialPassword = "password";
      extraGroups = [
        "wheel"
        "docker"
        "lxd"
        "libvirtd"
        "networkmanager"
        "video"
      ]; # Enable `sudo` for the user.
      shell = pkgs.zsh;
      packages = with pkgs; [ nixfmt ];
    };
  };
}
