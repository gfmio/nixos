{
  description = "";
  inputs = {
    nixpkgs = { url = "flake:nixpkgs/nixpkgs-unstable"; };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "flake:home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, home-manager, impermanence, ... }@inputs:
    let flakeContext = { inherit inputs; };
    in {
      devShells = {
        aarch64-darwin = {
          example = import ./devShells/example.nix flakeContext {
            system = "aarch64-darwin";
          };
        };
        aarch64-linux = {
          example = import ./devShells/example.nix flakeContext {
            system = "aarch64-linux";
          };
        };
        i686-linux = {
          example = import ./devShells/example.nix flakeContext {
            system = "i686-linux";
          };
        };
        x86_64-darwin = {
          example = import ./devShells/example.nix flakeContext {
            system = "x86_64-darwin";
          };
        };
        x86_64-linux = {
          example = import ./devShells/example.nix flakeContext {
            system = "x86_64-linux";
          };
        };
      };
      homeConfigurations = {
        gfmio = import ./homeConfigurations/gfmio.nix flakeContext;
      };
      homeModules = {
        alacritty = import ./homeModules/alacritty.nix flakeContext;
        chromium = import ./homeModules/chromium.nix flakeContext;
        firefox = import ./homeModules/firefox.nix flakeContext;
        git = import ./homeModules/git.nix flakeContext;
        gnomeDiskUtility =
          import ./homeModules/gnome-disk-utility.nix flakeContext;
        gnomeKeyring =
          import ./homeModules/gnome-keyring.nix flakeContext;
        gnomePasswordsafe =
          import ./homeModules/gnome-passwordsafe.nix flakeContext;
        gpg = import ./homeModules/gpg.nix flakeContext;
        htop = import ./homeModules/htop.nix flakeContext;
        i3 = import ./homeModules/i3.nix flakeContext;
        i3status = import ./homeModules/i3status.nix flakeContext;
        kitty = import ./homeModules/kitty.nix flakeContext;
        networking = import ./homeModules/networking.nix flakeContext;
        picom = import ./homeModules/picom.nix flakeContext;
        slack = import ./homeModules/slack.nix flakeContext;
        ssh = import ./homeModules/ssh.nix flakeContext;
        sublime = import ./homeModules/sublime.nix flakeContext;
        sway = import ./homeModules/sway.nix flakeContext;
        tmux = import ./homeModules/tmux.nix flakeContext;
        vscode = import ./homeModules/vscode.nix flakeContext;
        x = import ./homeModules/x.nix flakeContext;
        xdg = import ./homeModules/xdg.nix flakeContext;
        zsh = import ./homeModules/zsh.nix flakeContext;
      };
      nixosConfigurations = {
        # Desktop PC NixOS VM
        gfmio-nixos-vm =
          import ./nixosConfigurations/gfmio-nixos-vm/configuration.nix flakeContext {
            system = "x86_64-linux";
          };
        # Xiaomi notebook
        xiaomi =
          import ./nixosConfigurations/xiaomi/configuration.nix flakeContext {
            system = "x86_64-linux";
          };
        # UTM NixOS VM on macOS
        nixos-vm-aarch64-linux =
          import ./nixosConfigurations/nixos-vm/configuration.nix flakeContext {
            system = "aarch64-linux";
          };
        # Same buy for amd64 (currently unused)
        nixos-vm-x86_64-linux =
          import ./nixosConfigurations/nixos-vm/configuration.nix flakeContext {
            system = "x86_64-linux";
          };
      };
      nixosModules = {
        users = { gfmio = import ./nixosModules/users/gfmio.nix flakeContext; };

        bluetooth = import ./nixosModules/bluetooth.nix flakeContext;
        boot = import ./nixosModules/boot.nix flakeContext;
        clamav = import ./nixosModules/clamav.nix flakeContext;
        console = import ./nixosModules/console.nix flakeContext;
        cups = import ./nixosModules/cups.nix flakeContext;
        dbus = import ./nixosModules/dbus.nix flakeContext;
        dconf = import ./nixosModules/dconf.nix flakeContext;
        disk-encryption =
          import ./nixosModules/disk-encryption.nix flakeContext;
        displayManager = import ./nixosModules/displayManager.nix flakeContext;
        dns = import ./nixosModules/dns.nix flakeContext;
        docker = import ./nixosModules/docker.nix flakeContext;
        flatpak = import ./nixosModules/flatpak.nix flakeContext;
        fonts = import ./nixosModules/fonts.nix flakeContext;
        gnome = import ./nixosModules/gnome.nix flakeContext;
        gnomeKeyring = import ./nixosModules/gnome-keyring.nix flakeContext;
        gpg = import ./nixosModules/gpg.nix flakeContext;
        hardware = import ./nixosModules/hardware.nix flakeContext;
        i18n = import ./nixosModules/i18n.nix flakeContext;
        i3 = import ./nixosModules/i3.nix flakeContext;
        impermanence = import ./nixosModules/impermanence.nix flakeContext;
        intel = import ./nixosModules/intel.nix flakeContext;
        kernel = import ./nixosModules/kernel.nix flakeContext;
        libvirt = import ./nixosModules/libvirt.nix flakeContext;
        logind = import ./nixosModules/logind.nix flakeContext;
        lxd = import ./nixosModules/lxd.nix flakeContext;
        netdata = import ./nixosModules/netdata.nix flakeContext;
        networking = import ./nixosModules/networking.nix flakeContext;
        nix = import ./nixosModules/nix.nix flakeContext;
        nvidia = import ./nixosModules/nvidia.nix flakeContext;
        packages = import ./nixosModules/packages.nix flakeContext;
        podman = import ./nixosModules/podman.nix flakeContext;
        power = import ./nixosModules/power.nix flakeContext;
        qemu = import ./nixosModules/qemu.nix flakeContext;
        redshift = import ./nixosModules/redshift.nix flakeContext;
        restic = import ./nixosModules/restic.nix flakeContext;
        security = import ./nixosModules/security.nix flakeContext;
        smart = import ./nixosModules/smart.nix flakeContext;
        sound = import ./nixosModules/sound.nix flakeContext;
        ssh = import ./nixosModules/ssh.nix flakeContext;
        sway = import ./nixosModules/sway.nix flakeContext;
        syncthing = import ./nixosModules/syncthing.nix flakeContext;
        system = import ./nixosModules/system.nix flakeContext;
        thermal = import ./nixosModules/thermal.nix flakeContext;
        time = import ./nixosModules/time.nix flakeContext;
        tor = import ./nixosModules/tor.nix flakeContext;
        users-defaults = import ./nixosModules/users-defaults.nix flakeContext;
        virtualbox = import ./nixosModules/virtualbox.nix flakeContext;
        wayland = import ./nixosModules/wayland.nix flakeContext;
        x = import ./nixosModules/x.nix flakeContext;
        xdg = import ./nixosModules/xdg.nix flakeContext;
        xrdp = import ./nixosModules/xrdp.nix flakeContext;
      };
      packages = {
        x86_64-linux = {
          nixos-vm = import ./packages/nixos-vm.nix flakeContext {
            system = "x86_64-linux";
          };
          xiaomi = import ./packages/xiaomi.nix flakeContext {
            system = "x86_64-linux";
          };
        };
        aarch64-linux = {
          nixos-vm = import ./packages/nixos-vm.nix flakeContext {
            system = "aarch64-linux";
          };
        };
      };
    };
}
