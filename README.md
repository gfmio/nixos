# nixos-vm

This projects contains my nixos vm config.

## Usage

Install nixos from the boot image and copy the contents of this file to `/etc/nixos/configuration.nix`.

Then run `nixos-rebuild switch`.

## Plan

- Create VM base images using packer
- Use Vagrant for locally testing VMs
- Use nixos for Docker

- Option 1: VM runs with VNC: Use QXL/Spice for optimal performance, check what performance is maximally possible (with and without hardware support)
- Option 2: VM runs with RDP: No display, just exposes an RDP server, SSH for debugging
- Option 3: VM runs with graphics card embedded: Use nvidia drivers or similar
- Option 4: Bare metal runtime with access to all devices, use actual drivers or iommu if used as a hypervisor
