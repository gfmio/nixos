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
    hardware = {
      enable = true;
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
    };
    boot = {
      enable = true;
    };
    kernel = {
      enable = true;
    };
    system = {
      enable = true;
    };
    smart = {
      enable = false;
    };
    thermal = {
      enable = false;
    };
    power = {
      enable = false;
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
    lxd = {
      enable = true;
    };
    libvirt = {
      enable = true;
    };
    virtualbox = {
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
    flatpak = {
      enable = true;
    };
    clamav = {
      enable = false;
    };
    gnome-keyring = {
      enable = true;
    };
    netdata = {
      enable = true;
    };
    bluetooth = {
      enable = false;
    };
  };


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

  # # # List packages installed in system profile.
  # # environment.systemPackages = with pkgs; [
  # #   # Utils
  # #   wget
  # #   neofetch
  # #   micro
  # #   ncdu
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
