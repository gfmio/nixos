{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./common.nix
    ./modules/modules.nix
  ];
}
