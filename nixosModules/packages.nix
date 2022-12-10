# System package settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.packages;
in {
  imports = [ ];

  options = {
    modules = {
      packages = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    #
    # System packages
    #

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim
      git
      gitAndTools.diff-so-fancy
      wget
      gcc
      pkg-config
      openssl
      libsecret
      pciutils

      curl
      _9pfs

      alacritty
      kitty

      gnome3.adwaita-icon-theme
      gnomeExtensions.appindicator
      gnome3.gnome-settings-daemon
      gnome3.nautilus

      remmina

      # google-chrome
      # chromium
      # firefox

      # music stuff
      # https://nixos.wiki/wiki/JACK
      # guitarix
      # qjackctl
      # jack2Full

      # themes
      # theme-vertex
      # numix-gtk-theme
      # tango-icon-theme
      # numix-icon-theme
      # numix-icon-theme-circle

      # Utils
      wget
      # neofetch
      # micro
      # ncdu
      ntfs3g
      # ripgrep
      file
      htop
      speedtest-cli
      strace
      awscli
      freerdp
      # google-cloud-sdk
      # vault
      # exa
      # lazygit
      # bat
      # libsForQt5.vlc
      gparted
      tree
      rsync
      openssl
      docker-compose
      # nload
      sysbench
      # geekbench # not compatible with aarch64
      psmisc # provides: fuser, killall, pstree, peekfd
      # ethtool
      lsof
      tokei # fast cloc alternative in rust
      # dos2unix  # Convert between DOS and Unix line endings
      # socat
      # ipcalc
      whois
      dnsutils
      iperf
      netcat
      nmap
      openvpn
      networkmanager-openvpn
      pavucontrol # PulseAudio Volume Control, GUI
      # hyper

      # Nix tools
      # nix-du #https://github.com/symphorien/nix-du
      # common-updater-scripts
      # nixops
      # nix-review
      # nix-universal-prefetch

      # Dev
      cmake
      # bundix
      # nodejs-11_x
      # ruby_2_6
      # php73
      # php73Packages.composer
      # python27Full
      # python37Full
      # go_1_12
      # shellcheck
      git
      # solargraph # ruby tools
      # rubocop
      gtk3
      glade
      pkgconfig
      # Compiler and debugger
      gcc
      gdb
      # Build tools
      automake
      gnumake
      pkg-config
      clang-tools
      # Formatter
      # indent
      # Linter
      # splint
      # as (assembler) and ld, ld.bfd, ld.gold (linkers)
      binutils
      # Else
      # spotify # not compatible with aarch64
      # slack # not compatible with aarch64
      # filezilla
      # ansible
      # terraform_0_12
      vagrant
      # tdesktop
      libreoffice
      gimp
      # Media
      # plex-media-player
      vlc
      # VM
      open-vm-tools
      # Hardware
      lshw
      usbutils
      pciutils
      dmidecode
      lm_sensors
      hdparm
      smartmontools
      p7zip
      privoxy

      # compression
      pixz
      pigz
      pbzip2 # parallel (de-)compression
      unzip
      # Data formatters, accessors
      libxml2 # xmllint
      jq # json parser
      yq # same for yaml
      nvme-cli
      _1password
      ffsend
      graphviz
      dpkg
      # hexchat
      # pidgin
      # gitlab-runner
      exfat
      jnettop
      zip

      # https://www.mpscholten.de/nixos/2016/04/11/setting-up-vim-on-nixos.html
      (with import <nixpkgs> { };

        vim_configurable.customize {
          # Specifies the vim binary name
          # E.g. set this to "my-vim" and you need to type "my-vim" to open this vim
          # This allows to have multiple vim packages installed (e.g. with a different set of plugins)
          name = "vim";
          vimrcConfig.customRC = ''
            syntax on
            syntax enable
            set backupdir=/tmp      " save backup files (~) to /tmp
            set tabstop=4           " number of visual spaces per TAB
            set softtabstop=4       " number of spaces in tab when editing
            set expandtab           " tabs are spaces
            filetype indent on      " load filetype-specific indent files
            filetype on             " Enable file type detection
            set number              " show line numbers
            set showcmd             " show command in bottom bar
            set cursorline          " highlight current line
            set wildmenu            " visual autocomplete for command menu
            set lazyredraw          " redraw only when we need to.
            set showmatch           " highlight matching [{()}]
            set incsearch           " search as characters are entered
            set hlsearch            " highlight matches
            colorscheme pablo
            set backspace=indent,eol,start " backspace over everything in insert mode
          '';
        })
    ];

    #
    # gvfs (for nautlius)
    #

    services.gvfs.enable = true;

    #
    # Make vim the default EDITOR
    #

    environment.variables.EDITOR = "vim";
  };
}
