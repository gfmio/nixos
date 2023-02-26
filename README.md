# nixos

My personal nixos config.

* `devShells` contains development shells.

* `homeConfigurations` contains user-specific home-manager configurations. These load one or more `homeModules`.
* `homeModules` contains home-manager modules, that is groups of home-manager settings.

* `nixosConfigurations` contains system-level NixOS configurations. These load one or more `nixosModules` and home configurations.
* `nixosModules` contains nixos modules, that is groups of related nixos settings and home configurations.

## Setting up a new install

...

## Development Shells

...

## Building, testing, switching NixOS configurations

Use the name of your build as referenced in the `flake.nix`. For example if the name is `nixos-vm-aarch64-linux`, then the commands are:

```sh
sudo nixos-rebuild build --upgrade --impure --flake .#nixos-vm-aarch64-linux
sudo nixos-rebuild test --upgrade --impure --flake .#nixos-vm-aarch64-linux
sudo nixos-rebuild switch --upgrade --impure --flake .#nixos-vm-aarch64-linux
```

To test inside a VM on macOS with UTM, mount the repo as a VirtIO share and then mount it as a Plan 9 filesystem.

```sh
sudo mount -t 9p -o trans=virtio share /media/share -oversion=9p2000.L
cd /media/share
```

## Packages

...

```sh
nix build --impure .#packages.x86_64-linux.nixos-vm
```

## Misc

###  Starting a service after a desktop has been started

Use

```systemd
Requires=xdg-desktop-autostart.target
```
