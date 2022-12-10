# Font settings
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.fonts;
in {
  imports = [ ];

  options = {
    modules = {
      fonts = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
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
        corefonts # Microsoft free fonts
        ubuntu_font_family
        roboto # Android
      ];
    };
  };
}
