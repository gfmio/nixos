# nixos-vm

This projects contains my nixos vm config.

## Usage

Install nixos from the boot image and copy the contents of this file to `/etc/nixos/configuration.nix`.

Then run `nixos-rebuild switch`.

Install home-manager and copy the contents of `home.nix` to `$HOME/.config/nixpkgs/home.nix`.

```sh
# Rebuild system packages
sudo nixos-rebuild switch

# Rebuild user packages
home-manager switch
```

## Plan

- Create VM base images using packer
- Use Vagrant for locally testing VMs
- Use nixos for Docker

- Option 1: VM runs with VNC: Use QXL/Spice for optimal performance, check what performance is maximally possible (with and without hardware support)
- Option 2: VM runs with RDP: No display, just exposes an RDP server, SSH for debugging
- Option 3: VM runs with graphics card embedded: Use nvidia drivers or similar
- Option 4: Bare metal runtime with access to all devices, use actual drivers or iommu if used as a hypervisor

## To do

- [x] Split out the main configuration into manageable chunks
- [ ] Integrate my usual config files
- [x] Set up home manager
- [x] Configure common utilities
  - [x] VS Code
    - [x] Extensions
    - [x] Settings
  - [x] Sublime Text
  - [x] docker
  - [x] podman
  - [x] chromium
    - [x] extensions
    - [ ] settings
  - [x] firefox
    - [ ] extensions
    - [ ] settings
- [ ] Have a separate partition for /home
- [ ] Verify it works on physical devices
- [ ] xrdp
  - [x] basic support
  - [x] clipboard support
  - [ ] audio support
- [x] Ensure that the clipboard works in RDP sessions (I have no idea why though)
- [x] RDP and VNC client
- [ ] Backups
- [ ] Disk encryption

## Resources

- <https://github.com/angristan/nixos-config/blob/master/configuration.nix>
- <https://github.com/msfjarvis/dotfiles/blob/main/nixos/home-manager.nix>
- <https://gist.github.com/AcouBass/4f5bcb3410f14bd5063a718b1d53bc4c>
- <https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/ananicy/default.nix>
