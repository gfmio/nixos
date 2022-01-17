#!/bin/sh

cat nixos/system/configuration.nix | sudo tee /etc/nixos/configuration.nix
# cat nixos/system/hardware-configuration.nix | sudo tee /etc/nixos/hardware-configuration.nix

cat nixos/user/home.nix | sudo tee $HOME/.config/nixpkgs/home.nix
