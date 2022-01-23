{ config, lib, pkgs, ... }:

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

  modules = {
    # Enable nvidia, qemu or neither
    intel = {
      enable = false;
    };
    nvidia = {
      enable = true;
    };
    qemu = {
      enable = false;
    };
    boot = {
      enable = true;
    };
    time = {
      enable = true;
    };
    security = {
      enable = true;
    };
    networking = {
      enable = true;
      hostname = "gfmio-nixos";
      # TODO: Ethernet adapters, wireless, firewall
    };
    i18n = {
      enable = true;
    };
    sound = {
      enable = true;
    };
    x = {
      enable = true;
    };
    displayManager = {
      enable = true;
      displayManager = "gdm";
    };
    gnome = {
      enable = false;
    };
    sway = {
      enable = false;
    };
    i3 = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
    users = {
      enable = true;
    };
    cups = {
      enable = true;
    };
    ssh = {
      enable = true;
      permitRootLogin = false;
      passwordAuthentication = true;
    };
    gpg = {
      enable = true;
    };
    mtr = {
      enable = true;
    };
    pipewire = {
      enable = true;
    };
    xrdp = {
      enable = true;
    };
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
    };
    fonts = {
      enable = true;
    };
    packages = {
      enable = true;
    };
    restic = {
      enable = false;
    };
  };

  # # Use latest kernel
  # # boot.kernelPackages will use linuxPackages by default, so no need to define it
  # nixpkgs.config.packageOverrides = in_pkgs :
  #   {
  #     linuxPackages = in_pkgs.linuxPackages_latest;
  #   };
  # # No access time and continuous TRIM for SSD
  # fileSystems."/".options = [ "noatime" "discard" ];
  # # If non-empty, write log messages to the specified TTY device.
  # services.journald.console = "/dev/tty12";
  # # Enable Kernel same-page merging
  # hardware.ksm.enable = true;

  # # Enable all the firmware
  # hardware.enableAllFirmware = true;
  # # Enable all the firmware with a license allowing redistribution. (i.e. free firmware and firmware-linux-nonfree)
  # hardware.enableRedistributableFirmware = true;

  # # Sysctl params
  # boot.kernel.sysctl = {
  #   "fs.inotify.max_user_watches" = 524288; # Allow VS Code to watch more files
  # };

  # # A DBus service that allows applications to update firmware
  # services.fwupd.enable = true;

  # # Check S.M.A.R.T status of all disks and notify in case of errors
  # services.smartd = {
  #   enable = true;
  #   # Monitor all devices connected to the machine at the time it's being started
  #   autodetect = true;
  #   notifications = {
  #     x11.enable = if config.services.xserver.enable then true else false;
  #     wall.enable = true; # send wall notifications to all users
  #   };
  # };

  # # Enable entropy daemon which refills /dev/random when low
  # services.haveged.enable = true;

  # # Add the NixOS Manual on virtual console 8
  # services.nixosManual.showManual = true;

  # # Install + setcap
  # programs.iftop.enable = true;
  # programs.iotop.enable = true;
  # programs.mtr.enable = true;

  # # Thermals and cooling
  # services.thermald.enable = true;
  # # This includes support for suspend-to-RAM and powersave features on laptops
  # powerManagement.enable = true;
  # # Enable powertop auto tuning on startup.
  # powerManagement.powertop.enable = false;
  # # IDK if TLP is useful/conflicts with powerManagement
  # services.tlp.enable = false;
  # services.tlp.extraConfig = "USB_AUTOSUSPEND=0";

  # # Install LXD
  # virtualisation.lxd.enable = true;
  # # Install VB
  # virtualisation.virtualbox.host.enable = true;
  # # Libvirtd (Qemu)
  # virtualisation.libvirtd.enable = true;

  # # Periodically update the database of files used by the locate command
  # services.locate.enable = true;

  # # Enable Flatpak
  # #services.flatpak.enable = true
  # # No snap yet: https://github.com/NixOS/nixpkgs/issues/30336

  # # Enable ClamAV, an open source antivirus engine
  # #services.clamav.daemon.enable = true;
  # # Enable ClamAV freshclam updater.
  # #services.clamav.updater.enable = true;

  # # Monitoring
  # services.netdata = {
  #  enable = true;
  #  config = {
  #    global = {
  #      "default port" = "19999";
  #      "bind to" = "127.0.0.1";
  #    };
  #  };
  # };

  # # Bluetooth
  # # https://nixos.wiki/wiki/Bluetooth
  # hardware.bluetooth.enable = false;
  # # Don't power up the default Bluetooth controller on boot
  # hardware.bluetooth.powerOnBoot = false;

  # environment.gnome3.excludePackages = with pkgs.gnome3; [
  #   epiphany
  #   evolution
  #   gnome-maps
  #   accerciser
  # ];

  # # Enable GNOME Keyring daemon
  # services.gnome3.gnome-keyring.enable = true;
  # # Enable Chrome GNOME Shell native host connector
  # # This is a DBus service allowing to install GNOME Shell extensions from a web browser.
  # services.gnome3.chrome-gnome-shell.enable = true;

  # # this is required for mounting android phones
  # # over mtp://
  # services.gvfs.enable = true;

  # # # Syncthing service config

  # # syncthing = {
  # #   enable = true;
	# #   useInotify = true;
	# #   all_proxy = null;
  # #   dataDir = "/home/eddie/.syncthing";
  # #   user = "eddie";
  # # };

  # # ## DNSCrypt + DNSMasq

  # # dnscrypt-proxy = {
  # #   enable = true;
  # #   localPort = 43;
  # # };
  # # dnsmasq = {
  # #   enable = true;
  # #   servers = [ "127.0.0.1#43" ];
  # # };

  # # ## Tor + Privoxy

  # # privoxy.enable = true;
  # # tor = {
  # #   enable = true;
  # #   client = {
  # #   	enable = true;
  # #   	privoxy.enable = true;
  # #   };
  # #   tsocks.enable = true;
  # # };

  # # # Redshift

  # # redshift = {
  # #   enable = true;
  # #   latitude = "53.5615";
  # #   longitude = ".3268";
  # # };
  # # tlp.enable = true;
  # # udisks2.enable = true;
  # # printing.enable = true;

  # # system.autoUpgrade.enable = true;

  # # system packages
  # # environment.systemPackages = with pkgs; with qt5; with libsForQt5; with plasma5; with kdeApplications; [

  # #   # general desktop stuff
  # # firefox claws-mail qutebrowser midori
  # # xscreensaver

  # # # music stuff
  # # guitarix qjackctl jack2Full
  # # # themes
  # # theme-vertex numix-gtk-theme
  # # tango-icon-theme numix-icon-theme numix-icon-theme-circle
  # # ]
  # # ++builtins.filter lib.isDerivation (builtins.attrValues pkgs.plasma5)
  # # ++builtins.filter lib.isDerivation (builtins.attrValues pkgs.kdeApplications);

  # environment.systemPackages = with pkgs; [
  #   gitAndTools.diff-so-fancy
  # ];

  # # # List packages installed in system profile.
  # # environment.systemPackages = with pkgs; [
  # #   # Utils
  # #   wget
  # #   neofetch
  # #   micro
  # #   ncdu
  # #   gparted
  # #   ntfs3g
  # #   ripgrep
  # #   file
  # #   htop
  # #   speedtest-cli
  # #   strace
  # #   awscli
  # #   freerdp
  # #   google-cloud-sdk
  # #   vault
  # #   exa
  # #   lazygit
  # #   bat
  # #   libsForQt5.vlc
  # #   gparted
  # #   tree
  # #   rsync
  # #   openssl
  # #   docker-compose
  # #   nload
  # #   sysbench
  # #   geekbench
  # #   psmisc  # provides: fuser, killall, pstree, peekfd
  # #   ethtool
  # #   lsof
  # #   tokei  # fast cloc alternative in rust
  # #   dos2unix  # Convert between DOS and Unix line endings
  # #   socat
  # #   ipcalc
  # #   whois
  # #   dnsutils
  # #   iperf
  # #   netcat
  # #   nmap
  # #   speedtest-cli
  # #   openvpn
  # #   networkmanager-openvpn
  # #   ntfs3g
  # #   pavucontrol # PulseAudio Volume Control, GUI
  # #   #hyper
  # #   # Nix tools
  # #   nix-du #https://github.com/symphorien/nix-du
  # #   common-updater-scripts
  # #   nixops
  # #   nix-review
  # #   nix-universal-prefetch

  # #   # Dev
  # #   cmake
  # #   bundix
  # #   vscode
  # #   nodejs-11_x
  # #   ruby_2_6
  # #   php73
  # # 	php73Packages.composer
  # #   python27Full
  # #   python37Full
  # #   go_1_12
  # #   sublime3
  # #   shellcheck
  # #   git
  # #   solargraph # ruby tools
  # #   rubocop
  # #   gtk3
  # #   gnome3.glade
  # #   pkgconfig
  # #   # Compiler and debugger
  # #   gcc gdb
  # #   # Build tools
  # #   automake
  # #   gnumake
  # #   pkg-config
  # #   clang-tools
  # #   # Formatter
  # #   indent
  # #   # Linter
  # #   splint
  # #   # as (assembler) and ld, ld.bfd, ld.gold (linkers)
  # #   binutils
  # #   # Else
  # #   google-chrome
  # #   chromium
  # #   spotify
  # #   slack
  # #   filezilla
  # #   firefox
  # #   ansible
  # #   terraform_0_12
  # #   vagrant
  # #   tdesktop
  # #   libreoffice
  # #   gimp
  # #   # Media
  # #   plex-media-player
  # #   # VM
  # #   open-vm-tools
  # #   # Hardware
  # #   lshw
  # #   usbutils
  # #   pciutils
  # #   dmidecode
  # #   lm_sensors
  # #   hdparm
  # #   smartmontools
  # #   p7zip
  # #   privoxy

  # #   # compression
  # #   pixz pigz pbzip2 # parallel (de-)compression
  # #   unzip
  # #   # Data formatters, accessors
  # #   libxml2  # xmllint
  # #   jq  # json parser
  # #   yq  # same for yaml
  # #   nvme-cli
  # #   _1password
  # #   ffsend
  # #   graphviz
  # #   dpkg
  # #   hexchat
  # #   pidgin
  # #   gitlab-runner
  # #   exfat
  # #   jnettop
  # #   zip

  # #   # https://www.mpscholten.de/nixos/2016/04/11/setting-up-vim-on-nixos.html
  # #   (
  # #     with import <nixpkgs> {};

  # #     vim_configurable.customize {
  # #       # Specifies the vim binary name
  # #       # E.g. set this to "my-vim" and you need to type "my-vim" to open this vim
  # #       # This allows to have multiple vim packages installed (e.g. with a different set of plugins)
  # #       name = "vim";
  # #       vimrcConfig.customRC = ''
  # #         syntax on
  # #         syntax enable
  # #         set backupdir=/tmp      " save backup files (~) to /tmp
  # #         set tabstop=4           " number of visual spaces per TAB
  # #         set softtabstop=4       " number of spaces in tab when editing
  # #         set expandtab           " tabs are spaces
  # #         filetype indent on      " load filetype-specific indent files
  # #         filetype on             " Enable file type detection
  # #         set number              " show line numbers
  # #         set showcmd             " show command in bottom bar
  # #         set cursorline          " highlight current line
  # #         set wildmenu            " visual autocomplete for command menu
  # #         set lazyredraw          " redraw only when we need to.
  # #         set showmatch           " highlight matching [{()}]
  # #         set incsearch           " search as characters are entered
  # #         set hlsearch            " highlight matches
  # #         colorscheme pablo
  # #         set backspace=indent,eol,start " backspace over everything in insert mode
  # #       '';
  # #     }
  # #   )
  # # ];
}
