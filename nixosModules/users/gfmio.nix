#
# gfmio user nixos module
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
        "wheel" # Enable `sudo` for the user.
        "docker"
        "lxd"
        "libvirtd"
        "networkmanager"
        "audio"
        "video"
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [ nixfmt ];
    };
  };
}
