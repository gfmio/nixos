#
# impermanence nixos module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.impermanence;
in {
  imports = [
    inputs.impermanence
  ];

  options = {
    modules = {
      impermanence = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        persistencePath = mkOption {
          type = types.str;
          default = "/nix/persistent/system";
        };
        files = mkOption {
          type = types.listOf types.str;
          default = [];
        };
        directories = mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.persistence = listToAttrs [
      { name = cfg.persistencePath;
        value = {
          # Hide these mount from the sidebar of file managers
          hideMounts = true;

          # Folders you want to map
          directories = [
            "/etc/nixos"
            "/etc/NetworkManager"
            "/root"
            "/var/log"
            "/var/lib"
            "/var/cache/nix"
          ] ++ cfg.directories;

          # Files you want to map
          files = [
            "/etc/machine-id"
            "/etc/nix/id_rsa"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
          ] ++ cfg.files;

          # # Similarly, you can map files and folders in users' home directories
          # users.lantian = {
          #   directories = [
          #     # Personal files
          #     "Desktop"
          #     "Documents"
          #     "Downloads"
          #     "Music"
          #     "Pictures"
          #     "Videos"

          #     # Config folders
          #     ".cache"
          #     ".config"
          #     ".gnupg"
          #     ".local"
          #     ".ssh"
          #   ];
          #   files = [ ];
          # };
        };
      }
    ];

    # Nix Daemon stores its temporary files under /tmp while packaging. If /tmp
    # is backed by RAM, the system may run out of memory while building large
    # packages (such as the Linux kernel).
    # /tmp in NixOS is not backed by RAM by default, but with our configuration,
    # /tmp will be placed on root folder's RAM drive. Therefore, we can move Nix
    # Daemon's temp files onto the disk. I'm moving it to /var/cache/nix for
    # example:

    systemd.services.nix-daemon = {
      environment = {
        # Location for temporary files
        TMPDIR = "/var/cache/nix";
      };
      serviceConfig = {
        # Create /var/cache/nix automatically on Nix Daemon start
        CacheDirectory = "nix";
      };
    };

    environment.variables.NIX_REMOTE = "daemon";
  };
}
