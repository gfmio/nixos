#!/bin/sh

sudo parted /dev/vda -- mklabel gpt;
sudo parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB;
sudo parted /dev/vda -- mkpart primary 512MiB 100%;
sudo parted /dev/vda -- set 1 esp on;

sudo mkfs.ext4 -L nixos /dev/vda2;
sudo mkfs.fat -F 32 -n boot /dev/vda1;

sudo mount /dev/disk/by-label/nixos /mnt;
sudo mkdir -p /mnt/boot;
sudo mount /dev/disk/by-label/boot /mnt/boot;

sudo nixos-generate-config --root /mnt;

sudo nixos-install;

sudo umount /mnt/boot;
sudo umount /mnt;

sudo reboot;
