#!/bin/sh

# Install home-manager

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

mkdir -p $HOME/.config/nixpkgs
touch $HOME/.config/nixpkgs/home.nix

nix-shell '<home-manager>' -A install
