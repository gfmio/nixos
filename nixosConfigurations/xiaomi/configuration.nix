{ inputs, ... }@flakeContext:
{ system }:
let
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      (inputs.self.nixosModules.users.gfmio { system = system; })
      inputs.self.nixosModules._1password
      inputs.self.nixosModules.bluetooth
      inputs.self.nixosModules.boot
      inputs.self.nixosModules.clamav
      inputs.self.nixosModules.console
      inputs.self.nixosModules.cups
      inputs.self.nixosModules.dbus
      inputs.self.nixosModules.dconf
      inputs.self.nixosModules.disk-encryption
      inputs.self.nixosModules.displayManager
      inputs.self.nixosModules.dns
      inputs.self.nixosModules.docker
      inputs.self.nixosModules.flatpak
      inputs.self.nixosModules.fonts
      inputs.self.nixosModules.gnome
      inputs.self.nixosModules.gnomeKeyring
      inputs.self.nixosModules.gpg
      inputs.self.nixosModules.hardware
      inputs.self.nixosModules.i18n
      inputs.self.nixosModules.i3
      inputs.self.nixosModules.impermanence
      inputs.self.nixosModules.intel
      inputs.self.nixosModules.kernel
      inputs.self.nixosModules.libvirt
      inputs.self.nixosModules.logind
      inputs.self.nixosModules.lxd
      inputs.self.nixosModules.netdata
      inputs.self.nixosModules.networking
      inputs.self.nixosModules.nix
      inputs.self.nixosModules.nvidia
      inputs.self.nixosModules.packages
      inputs.self.nixosModules.podman
      inputs.self.nixosModules.power
      inputs.self.nixosModules.qemu
      inputs.self.nixosModules.redshift
      inputs.self.nixosModules.restic
      inputs.self.nixosModules.security
      inputs.self.nixosModules.smart
      inputs.self.nixosModules.sound
      inputs.self.nixosModules.ssh
      inputs.self.nixosModules.sway
      inputs.self.nixosModules.syncthing
      inputs.self.nixosModules.system
      inputs.self.nixosModules.thermal
      inputs.self.nixosModules.time
      inputs.self.nixosModules.tor
      inputs.self.nixosModules.users-defaults
      inputs.self.nixosModules.virtualbox
      inputs.self.nixosModules.wayland
      inputs.self.nixosModules.x
      inputs.self.nixosModules.xdg
      inputs.self.nixosModules.xrdp
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
    config = {
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "23.05"; # Did you read the comment?

      # Allow unfree and broken packages
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      modules = {
        #
        # Basic system settings
        #

        hardware = {
          enable = true;
          # Enable nvidia, qemu or neither
          intel = { enable = true; };
          nvidia = {
            enable = true;
            enablePrime = true;
            primeMode = "offload"; # sync does not work
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
          qemu = { enable = false; };
        };
        boot = {
          enable = true;
          efiSysMountPoint = "/boot";
        };
        kernel = { enable = true; };
        system = { enable = true; };
        diskEncryption = { enable = false; };
        time = {
          enable = true;
          timeZone = "Europe/London";
        };
        security = { enable = true; };
        networking = {
          enable = true;
          hostname = "gfmio-xiaomi";
          # dhcpInterfaces = [ "enp1s0" ];
          dhcpInterfaces = [ ];
        };
        console = { enable = true; };
        i18n = {
          enable = true;
          # locale = "en_GB.utf-8";
          locale = "en_US.UTF-8";
          xkb = {
            layout = "us";
            variant = "mac";
          };
          console = { keyMap = "us"; };
        };
        ssh = {
          enable = true;
          permitRootLogin = false;
          passwordAuthentication = true;
        };
        users-defaults = { enable = true; };

        #
        # Desktop
        #

        smart = { enable = true; };
        thermal = { enable = true; };
        power = { enable = true; };
        sound = { enable = true; };
        cups = { enable = true; };
        xdg = { enable = true; };
        dconf = { enable = true; };
        dbus = { enable = true; };
        logind = { enable = true; };
        # gnome-keyring = { enable = true; };

        x = { enable = true; };
        wayland = { enable = true; };
        displayManager = {
          enable = true;
          displayManager = "gdm";
          # defaultSession = "gnome";
          # defaultSession = "none+i3";
          defaultSession = "sway";
        };
        gnome = { enable = false; };
        sway = { enable = true; };
        i3 = { enable = true; };

        #
        # Applications
        #

        gpg = { enable = true; };
        xrdp = {
          enable = true;
          defaultWindowManager = "i3";
        };
        # docker = { enable = true; };
        podman = { enable = true; };
        lxd = { enable = true; };
        libvirt = { enable = true; };
        virtualbox = { enable = false; };
        fonts = { enable = true; };
        packages = { enable = true; };
        restic = { enable = false; };
        flatpak = { enable = true; };
        clamav = { enable = false; };
        netdata = { enable = true; };
        bluetooth = { enable = true; };
        syncthing = { enable = false; };
        dns = { enable = false; };
        tor = { enable = false; };
        redshift = { enable = false; };
        impermanence = { enable = false; };
        _1password = { enable = true; };
      };
    };
  };
in inputs.nixpkgs.lib.nixosSystem {
  modules = [ nixosModule ];
  system = system;
}
