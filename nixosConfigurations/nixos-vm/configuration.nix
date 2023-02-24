{ inputs, ... }@flakeContext:
{ system }:
let
  nixosModule = { config, lib, pkgs, ... }: {
    imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      (inputs.self.nixosModules.users.gfmio { system = system; })
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

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      modules = {
        hardware = {
          enable = true;
          # Enable nvidia, qemu or neither
          intel = { enable = false; };
          nvidia = { enable = false; };
          qemu = { enable = true; };
        };
        boot = { enable = true; };
        kernel = { enable = true; };
        system = { enable = true; };
        diskEncryption = { enable = false; };
        smart = { enable = false; };
        thermal = { enable = false; };
        power = { enable = false; };
        time = {
          enable = true;
          timeZone = "Europe/London";
        };
        security = { enable = true; };
        networking = {
          enable = true;
          hostname = "gfmio-nixos";
          # dhcpInterfaces = [ "enp1s0" ];
          dhcpInterfaces = [ ];
        };
        console = { enable = true; };
        i18n = {
          enable = true;
          # locale = "en_GB.utf-8";
          locale = "en_US.UTF-8";
          xkb = {
            layout = "gb";
            variant = "mac";
          };
          console = { keyMap = "uk"; };
        };
        sound = { enable = true; };
        x = { enable = true; };
        displayManager = {
          enable = true;
          displayManager = "gdm";
          defaultSession = "gnome";
          # defaultSession = "none+i3";
        };
        gnome = { enable = true; };
        # sway = { enable = true; };
        sway = { enable = false; };
        i3 = { enable = false; };
        dconf = { enable = true; };
        users-defaults = { enable = true; };
        cups = { enable = true; };
        ssh = {
          enable = true;
          permitRootLogin = false;
          passwordAuthentication = true;
        };
        gpg = { enable = true; };
        xrdp = {
          enable = true;
          defaultWindowManager = "i3";
        };
        docker = { enable = false; };
        podman = { enable = true; dockerCompat = true; };
        lxd = { enable = true; };
        libvirt = { enable = true; };
        virtualbox = { enable = false; };
        fonts = { enable = true; };
        packages = { enable = true; };
        restic = { enable = false; };
        flatpak = { enable = true; };
        clamav = { enable = false; };
        # gnome-keyring = { enable = true; };
        netdata = { enable = true; };
        bluetooth = { enable = false; };
        syncthing = { enable = false; };
        dns = { enable = false; };
        tor = { enable = false; };
        redshift = { enable = false; };
        xdg = { enable = true; gtk = false; };
        dbus = { enable = true; };
        wayland = { enable = true; };
        logind = { enable = false; };
      };

      services.xserver.windowManager.i3 = { enable = true; };
      programs.sway = { enable = true; };

      # xdg-desktop-portal works by exposing a series of D-Bus interfaces
      # known as portals under a well-known name
      # (org.freedesktop.portal.Desktop) and object path
      # (/org/freedesktop/portal/desktop).
      # The portal interfaces include APIs for file access, opening URIs,
      # printing and others.

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        # gtk portal needed to make gtk apps happy
        # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
      # # Enable the GNOME Desktop Environment.
      # services.xserver.displayManager.gdm.enable = true;
      # services.xserver.desktopManager.gnome.enable = true;

      # nixpkgs.system-features = [ "gccarch-armv8-a" "nixos-test" "benchmark" "big-parallel" "kvm" ];

      # nixConfig.aarch64-darwin.extra-platforms = [ "x86_64-darwin" ];
      nix.extraOptions = ''
        extra-platforms = x86_64-linux
      '';

      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    };
  };
in inputs.nixpkgs.lib.nixosSystem {
  modules = [ nixosModule ];
  system = system;
}
