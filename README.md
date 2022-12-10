# nixos

My personal nixos config.

* `devShells` contains development shells.

* `homeConfigurations` contains user-specific home-manager configurations. These load one or more `homeModules`.
* `homeModules` contains home-manager modules, that is groups of home-manager settings.

* `nixosConfigurations` contains system-level NixOS configurations. These load one or more `nixosModules` and home configurations.
* `nixosModules` contains nixos modules, that is groups of related nixos settings and home configurations.

## Development Shells

```sh
sudo mount -t 9p -o trans=virtio share /media/share -oversion=9p2000.L
cd /media/share
sudo nixos-rebuild build --upgrade --impure --flake .#nixos-vm-aarch64-linux
sudo nixos-rebuild test --upgrade --impure --flake .#nixos-vm-aarch64-linux
sudo nixos-rebuild switch --upgrade --impure --flake .#nixos-vm-aarch64-linux
```

```sh
nix build --impure .#packages.x86_64-linux.nixos-vm
```
