#!/bin/sh

cat /etc/nixos/configuration.nix > nixos/system/configuration.nix
cat /etc/nixos/hardware-configuration.nix > nixos/system/hardware-configuration.nix

cat $HOME/.config/nixpkgs/home.nix > nixos/user/home.nix
