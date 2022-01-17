#!/bin/sh

cat nixos/system/configuration.nix | sudo tee /etc/nixos/configuration.nix
# cat nixos/system/hardware-configuration.nix | sudo tee /etc/nixos/hardware-configuration.nix

cat nixos/user/home.nix | tee $HOME/.config/nixpkgs/home.nix
cat nixos/user/config.nix | tee $HOME/.config/nixpkgs/config.nix
