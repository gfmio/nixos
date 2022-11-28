{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    ./common.nix
    ./modules/modules.nix
  ];
}
