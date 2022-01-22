{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    ./hardware-configuration.nix
    ./common.nix
    ./modules/modules.nix
  ];
}
