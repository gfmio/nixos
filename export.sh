#!/bin/sh

# System

cat hosts/nixos-test-vm/system/configuration.nix | sudo tee /etc/nixos/configuration.nix
cat hosts/nixos-test-vm/system/common.nix | sudo tee /etc/nixos/common.nix
# cat hosts/nixos-test-vm/system/hardware-configuration.nix | sudo tee /etc/nixos/hardware-configuration.nix
sudo rm -rf /etc/nixos/modules
sudo cp -R modules/system /etc/nixos/modules

# User

cat hosts/nixos-test-vm/user/home.nix | tee $HOME/.config/nixpkgs/home.nix
cat hosts/nixos-test-vm/user/config.nix | tee $HOME/.config/nixpkgs/config.nix
cat hosts/nixos-test-vm/user/common.nix | tee $HOME/.config/nixpkgs/common.nix
rm -rf $HOME/.config/nixpkgs/modules
cp -R modules/user $HOME/.config/nixpkgs/modules
