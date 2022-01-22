{ config, lib, pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./firefox.nix
  ];
}
