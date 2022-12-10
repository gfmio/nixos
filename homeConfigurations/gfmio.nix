{ inputs, ... }@flakeContext:
{ system, lib }:
let
  homeModule = { config, pkgs, ... }: {
    imports = [
      inputs.self.homeModules.alacritty
      inputs.self.homeModules.chromium
      inputs.self.homeModules.firefox
      inputs.self.homeModules.git
      inputs.self.homeModules.gnomeDiskUtility
      inputs.self.homeModules.gnomePasswordsafe
      inputs.self.homeModules.gpg
      inputs.self.homeModules.htop
      inputs.self.homeModules.i3
      inputs.self.homeModules.i3status
      inputs.self.homeModules.kitty
      inputs.self.homeModules.networking
      inputs.self.homeModules.picom
      inputs.self.homeModules.ssh
      inputs.self.homeModules.sublime
      inputs.self.homeModules.sway
      inputs.self.homeModules.tmux
      inputs.self.homeModules.vscode
      inputs.self.homeModules.x
      inputs.self.homeModules.zsh
    ];
    config = {
      # Add additional settings for the user here.
      # Most should be managed via other modules though
      home.stateVersion = "23.05";
      home.username = "gfmio";
      home.homeDirectory = "/home/gfmio";
      programs.home-manager.enable = true;
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [ ];

      modules = {
        x = {
          enable = true;
          scale = 1.0;
        };
        i3 = { enable = true; };
        i3status = {
          enable = true;
          ipv6 = false;
          wireless = false;
          battery = false;
        };
        chromium = { enable = true; };
        firefox = { enable = true; };
        vscode = { enable = true; };
        sublime = { enable = true; };
        ssh = { enable = true; };
        git = {
          enable = true;
          email = "git@gfm.io";
        };
        zsh = { enable = true; };
        htop = { enable = true; };
        tmux = { enable = true; };
        kitty = { enable = true; };
        alacritty = { enable = true; };
        picom = { enable = true; };
        networking = {
          enable = true;
          enableNetworkManagerApplet = false;
        };
        gpg = { enable = true; };
        gnome-passwordsafe = { enable = true; };
        sway = { enable = true; };
        gnome-disk-utility = { enable = true; };
      };
    };
  };
  nixosModule = { ... }: { home-manager.users.gfmio = homeModule; };
in ((inputs.home-manager.lib.homeManagerConfiguration {
  modules = [ homeModule ];
  pkgs = lib.getAttr system inputs.nixpkgs.legacyPackages;
}) // {
  inherit nixosModule;
})
