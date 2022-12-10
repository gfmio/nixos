# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{config, pkgs, ...}:

let
  dir = builtins.toString ./.;
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  # users.users.root.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AaAeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee username@host"
  # ];

  isoImage.contents = [
    {
      source = ./hosts;
      target = "/install/hosts";
    }
    {
      source = ./modules;
      target = "/install/modules";
    }
    {
      source = ./export.sh;
      target = "/install/export.sh";
    }
    {
      source = ./install.sh;
      target = "/install/install.sh";
    }
    {
      source = ./install-inside.sh;
      target = "/install/install-inside.sh";
    }
  ];
}
