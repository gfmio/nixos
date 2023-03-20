#!/bin/sh

DISK1=/dev/vda
DISK1P1=/dev/vda1
DISK1P2=/dev/vda2
DISK2=/dev/vdb
DISK2P1=/dev/vdb1

# Format the disks

sudo parted $DISK1 -- mklabel gpt;
sudo parted $DISK1 -- mkpart ESP fat32 0% 512MiB;
sudo parted $DISK1 -- set 1 esp on;
sudo parted $DISK1 -- mkpart primary 512MiB 100%;

sudo parted $DISK2 -- mklabel gpt;
sudo parted $DISK2 -- mkpart primary 0% 100%;

# Generate keyfiles

dd if=/dev/urandom of=./keyfile-root.bin bs=1024 count=4
dd if=/dev/urandom of=./keyfile-home.bin bs=1024 count=4

# Set up the system encryption

# Enter the passphrase which is used to unlock disk. You will enter this in grub on every boot
sudo cryptsetup luksFormat --type luks1 -c aes-xts-plain64 -s 256 -h sha512 $DISK1P2
sudo cryptsetup luksAddKey $DISK1P2 ./keyfile-root.bin

sudo cryptsetup luksOpen $DISK1P2 rootcryptlvm -d ./keyfile-root.bin

sudo cryptsetup luksFormat -c aes-xts-plain64 -s 256 -h sha512 $DISK2P1 -d ./keyfile-home.bin

sudo cryptsetup luksOpen $DISK2P1 homecryptlvm -d ./keyfile-home.bin

# The decrypted containers are now available at /dev/mapper/rootcryptlvm and /dev/mapper/homecryptlvm.

# Create a physical volume on top of the opened LUKS container:

sudo pvcreate /dev/mapper/rootcryptlvm
sudo pvcreate /dev/mapper/homecryptlvm

# Create a volume group (in this example named MyVolGroup, but it can be whatever you want) and add the previously created physical volume to it:

sudo vgcreate rootvg /dev/mapper/rootcryptlvm
sudo vgcreate homevg /dev/mapper/homecryptlvm

# Create all your logical volumes on the volume group:

sudo lvcreate -L 35G rootvg -n swap
sudo lvcreate -L 512M rootvg -n boot
sudo lvcreate -l 100%FREE rootvg -n root

sudo lvcreate -l 100%FREE homevg -n home

# Tip: If a logical volume will be formatted with ext4, leave at least 256 MiB free space in the volume group to allow using e2scrub(8). After creating the last volume with -l 100%FREE, this can be accomplished by reducing its size with

sudo lvreduce -L -256M rootvg/root
sudo lvreduce -L -256M homevg/home

# Format the file systems

sudo mkfs.fat -F 32 $DISK1P1

sudo mkfs.fat -F 32 /dev/rootvg/boot
sudo mkfs.ext4 /dev/rootvg/root
sudo mkfs.ext4 /dev/homevg/home
sudo mkswap /dev/rootvg/swap

# Mount the file systems

sudo mount -t tmpfs none /mnt
sudo mount --mkdir /dev/rootvg/boot /mnt/boot
sudo mount --mkdir /dev/rootvg/root /mnt/nix
sudo mount --mkdir /dev/homevg/home /mnt/home
sudo mount --mkdir $DISK1P1 /mnt/boot/efi
sudo swapon /dev/rootvg/swap

# Copy the keyfiles

sudo mkdir -p /mnt/nix/persistent/system/etc/secrets/initrd/nixos
sudo cp keyfile-root.bin keyfile-home.bin /mnt/nix/persistent/system/etc/secrets/initrd/nixos
sudo chmod 000 /mnt/nix/persistent/system/etc/secrets/initrd/nixos/keyfile*.bin

# Generate the NixOS config

sudo nixos-generate-config --root /mnt;

# Modify the config here

# Install NixOS

# sudo nixos-install;

# Unmount

# sudo umount /mnt/boot;
# sudo umount /mnt/home;
# sudo umount /mnt/nix;

# Reboot

# sudo reboot;
