#
# sway settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.sway;
in
{
  imports = [];

  options = {
    modules = {
      sway = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.portal.wlr.enable = true;

    programs.sway = {
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
        brightnessctl
      ];
    };

    nixpkgs.overlays = [
      (self: super: {
        wl-clipboard-x11 = super.stdenv.mkDerivation rec {
        pname = "wl-clipboard-x11";
        version = "5";
      
        src = super.fetchFromGitHub {
          owner = "brunelli";
          repo = "wl-clipboard-x11";
          rev = "v${version}";
          sha256 = "1y7jv7rps0sdzmm859wn2l8q4pg2x35smcrm7mbfxn5vrga0bslb";
        };
      
        dontBuild = true;
        dontConfigure = true;
        propagatedBuildInputs = [ super.wl-clipboard ];
        makeFlags = [ "PREFIX=$(out)" ];
        };
      
        xsel = self.wl-clipboard-x11;
        xclip = self.wl-clipboard-x11;
      })
    ];
  };
}
