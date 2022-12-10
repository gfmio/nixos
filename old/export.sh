#!/bin/sh

if [ ! -n "$1" ]; then
  echo "No host was supplied";
  exit 1;
fi

host=$1;

if [[ ! -d hosts/$name ]]; then
  echo "Unknown host $name";
  exit 1;
fi

# System

cat hosts/$host/system/configuration.nix | sudo tee /etc/nixos/configuration.nix &&
cat hosts/$host/system/common.nix | sudo tee /etc/nixos/common.nix &&
# cat hosts/$host/system/hardware-configuration.nix | sudo tee /etc/nixos/hardware-configuration.nix
sudo rm -rf /etc/nixos/modules &&
sudo cp -R modules/system /etc/nixos/modules &&

# User

cat hosts/$host/user/home.nix | tee $HOME/.config/nixpkgs/home.nix &&
cat hosts/$host/user/config.nix | tee $HOME/.config/nixpkgs/config.nix &&
cat hosts/$host/user/common.nix | tee $HOME/.config/nixpkgs/common.nix &&
rm -rf $HOME/.config/nixpkgs/modules &&
cp -R modules/user $HOME/.config/nixpkgs/modules
