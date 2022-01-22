{ config, lib, pkgs, ... }:

with lib;

let
  nvidia = true;
  qemu = false;
  sway = false;
  gnome = false;
  gdm = true;
  xrdp = true;
  i3 = true;
in
{
  #
  # Core nixos settings
  #

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  #
  # Modules
  #
  #
  # Boot configuration
  #

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = mkIf nvidia [ "nvidia-drm.modeset=1" ];
  boot.blacklistedKernelModules = mkIf nvidia [ "nouveau" ];
  boot.initrd.availableKernelModules = mkIf nvidia [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.cleanTmpDir = true;

  #
  # Timezone
  #

  time.timeZone = "Europe/London";

  # Use the systemd-timesyncd SNTP client to sync the system clock (enabled by default)
  services.timesyncd.enable = true;

  #
  # sudo
  #

  # Disable sudo password for the wheel group
  security.sudo.wheelNeedsPassword = false;

  #
  # Networking
  #

  networking.hostName = "gfmio-nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  #
  # Internationalisation
  #

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  #
  # Sound
  #

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  #
  # X window system
  #

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Drivers

  services.xserver.videoDrivers = if nvidia then [ "nvidia" ] else mkIf qemu [ "qxl" "modesetting" "fbdev"  ];

  hardware.nvidia.modesetting.enable = nvidia;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # GNOME

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = gdm;
  # services.xserver.displayManager.gdm.nvidiaWayland = nvidia;
  services.xserver.displayManager.gdm.nvidiaWayland = false;
  services.xserver.displayManager.gdm.wayland = false;

  services.xserver.displayManager.lightdm.enable = !gdm;

  services.xserver.desktopManager.gnome.enable = gnome;

  #
  # Sway
  #

  xdg.portal.wlr.enable = sway;

  programs.sway = mkIf sway {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      wdisplays
      wl-clipboard
    ];
  };

  #
  # i3
  #

  services.xserver.desktopManager.xterm.enable = !i3;
  services.xserver.displayManager.defaultSession = mkIf i3 "none+i3";

  services.xserver.windowManager.i3 = mkIf i3 {
    enable = true;
    extraPackages = with pkgs; [
      dmenu #application launcher most people use
      i3status # gives you the default i3 status bar
      i3lock #default i3 screen locker
      i3blocks #if you are planning on using i3blocks over i3status
    ];
  };

  #
  # dconf
  #

  programs.dconf.enable = true;

  #
  # Users
  #

  users.users.root.initialPassword = "root";

  users.users.gfmio = {
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;
  };

  #
  # Printing (CUPS)
  #

  services.printing.enable = true;

  #
  # SSH
  #

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  #
  # GPG
  #

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  #
  # MTR
  #

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  #
  # QEMU guest
  #

  services.qemuGuest.enable = qemu;
  services.spice-vdagentd.enable = qemu;

  #
  # Pipewire
  #

  services.pipewire.enable = true;

  #
  # xrdp
  #

  services.xrdp = mkIf xrdp {
    enable = true;
    defaultWindowManager = "i3";
  };
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  #
  # Docker
  #

  virtualisation.docker.enable = true;

  #
  # Podman
  #

  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = false;
  };

  #
  # gvfs (for nautlius)
  #

  services.gvfs.enable = true;

  #
  # System packages
  #

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    pciutils
    alacritty
    kitty
    gcc
    libsecret
    pkg-config
    openssl
    git
    arandr
    dex
    xss-lock
    gnome3.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome3.gnome-settings-daemon
    gnome3.nautilus
    remmina
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk # Chinese, Japanese, Korean
      noto-fonts-emoji
      noto-fonts-extra
      fira-code # Monospace font with programming ligatures
      hack-font # A typeface designed for source code
      fira-mono # Mozilla's typeface for Firefox OS
      corefonts  # Microsoft free fonts
      ubuntu_font_family
      roboto # Android
    ];
  };

  nix = {
    # Automatically run the garbage collector
    gc.automatic = false;
    gc.dates = "12:45";
    # Automatically run the nix store optimiser
    optimise.automatic = false;
    optimise.dates = [ "12:55" ];
    # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
    autoOptimiseStore = true;
    # maximum number of concurrent tasks during one build
    buildCores = 4;
    # maximum number of jobs that Nix will try to build in parallel
    # "auto" is broken: https://github.com/NixOS/nixpkgs/issues/50623
    maxJobs = 4;
    # perform builds in a sandboxed environment
    useSandbox = true;
  };

  environment.variables.EDITOR = "vim";
}
