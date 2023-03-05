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
      nixpkgs.config.allowBroken = true;

     environment.sessionVariables.NIXOS_OZONE_WL = "1";

      modules = {
        hardware = {
          enable = true;
          # Enable nvidia, qemu or neither
          intel = { enable = false; };
          nvidia = { enable = true; };
          qemu = { enable = true; };
        };
        boot = { enable = true; loader = "systemd-boot"; };
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
          defaultSession = "sway";
          # defaultSession = "none+i3";
        };
        gnome = { enable = true; };
        sway = { enable = true; debug = true; verbose = true; unsupportedGPU = true;  };
        i3 = { enable = true; };
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
          enable = false;
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

      # nixpkgs.system-features = [ "gccarch-armv8-a" "nixos-test" "benchmark" "big-parallel" "kvm" ];

      # nixConfig.aarch64-darwin.extra-platforms = [ "x86_64-darwin" ];
      # nix.extraOptions = ''
      #   extra-platforms = x86_64-linux
      # '';

      # boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    };
  };
in inputs.nixpkgs.lib.nixosSystem {
  modules = [ nixosModule ];
  system = system;
}



# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, pkgs, ... }:

# {
#   imports =
#     [ # Include the results of the hardware scan.
#       ./hardware-configuration.nix
#     ];

#   # Bootloader.
#   boot.loader.systemd-boot.enable = true;
#   boot.loader.efi.canTouchEfiVariables = true;
#   boot.loader.efi.efiSysMountPoint = "/boot/efi";

#   networking.hostName = "gfmio-nixos"; # Define your hostname.
#   # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

#   # Configure network proxy if necessary
#   # networking.proxy.default = "http://user:password@proxy:port/";
#   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

#   # Enable networking
#   networking.networkmanager.enable = true;

#   # Set your time zone.
#   time.timeZone = "Europe/London";

#   # Select internationalisation properties.
#   i18n.defaultLocale = "en_GB.UTF-8";

#   boot.kernelParams = [ "nvidia-drm.modeset=1" ];
#   boot.blacklistedKernelModules = [ "nouveau" ];
#   boot.initrd.availableKernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
#   services.xserver.videoDrivers = [ "nvidia" ];
#   hardware.nvidia.modesetting.enable = true;
#   hardware.nvidia.open = false;
#   hardware.opengl.extraPackages = with pkgs; [ mpi linuxPackages.nvidia_x11 ];

#   i18n.extraLocaleSettings = {
#     LC_ADDRESS = "en_GB.UTF-8";
#     LC_IDENTIFICATION = "en_GB.UTF-8";
#     LC_MEASUREMENT = "en_GB.UTF-8";
#     LC_MONETARY = "en_GB.UTF-8";
#     LC_NAME = "en_GB.UTF-8";
#     LC_NUMERIC = "en_GB.UTF-8";
#     LC_PAPER = "en_GB.UTF-8";
#     LC_TELEPHONE = "en_GB.UTF-8";
#     LC_TIME = "en_GB.UTF-8";
#   };

#   # Enable the X11 windowing system.
#   services.xserver.enable = true;

#   # Enable the GNOME Desktop Environment.
#   services.xserver.displayManager.gdm.enable = true;
#   services.xserver.desktopManager.gnome.enable = true;

#   # Configure keymap in X11
#   services.xserver = {
#     layout = "gb";
#     xkbVariant = "mac_intl";
#   };

#   # Configure console keymap
#   console.keyMap = "uk";

#   # Enable CUPS to print documents.
#   services.printing.enable = true;

#   # Enable sound with pipewire.
#   sound.enable = true;
#   hardware.pulseaudio.enable = false;
#   security.rtkit.enable = true;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment this
#     #jack.enable = true;

#     # use the example session manager (no others are packaged yet so this is enabled by default,
#     # no need to redefine it in your config for now)
#     #media-session.enable = true;
#   };

#   # Enable touchpad support (enabled default in most desktopManager).
#   # services.xserver.libinput.enable = true;

#   # Define a user account. Don't forget to set a password with ‘passwd’.
#   users.users.gfmio = {
#     isNormalUser = true;
#     description = "Frederique Mittelstaedt";
#     extraGroups = [ "networkmanager" "wheel" ];
#     packages = with pkgs; [
#       firefox
#     #  thunderbird
#     ];
#   };

#   # Allow unfree packages
#   nixpkgs.config.allowUnfree = true;

#   # List packages installed in system profile. To search, run:
#   # $ nix search wget
#   environment.systemPackages = with pkgs; [
#     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#     wget
#     git
#   ];

#   # Some programs need SUID wrappers, can be configured further or are
#   # started in user sessions.
#   # programs.mtr.enable = true;
#   # programs.gnupg.agent = {
#   #   enable = true;
#   #   enableSSHSupport = true;
#   # };

#   # List services that you want to enable:

#   # Enable the OpenSSH daemon.
#   services.openssh.enable = true;

#   # Open ports in the firewall.
#   # networking.firewall.allowedTCPPorts = [ ... ];
#   # networking.firewall.allowedUDPPorts = [ ... ];
#   # Or disable the firewall altogether.
#   networking.firewall.enable = false;

#   # This value determines the NixOS release from which the default
#   # settings for stateful data, like file locations and database versions
#   # on your system were taken. It‘s perfectly fine and recommended to leave
#   # this value at the release version of the first install of this system.
#   # Before changing this value read the documentation for this option
#   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#   system.stateVersion = "22.11"; # Did you read the comment?

# }
