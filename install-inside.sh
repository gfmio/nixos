#!/bin/sh

# Install home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

mkdir -p $HOME/.config/nixpkgs
touch $HOME/.config/nixpkgs/home.nix
