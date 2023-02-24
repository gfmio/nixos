#
# slack home module
#
# TODO: Customize slack
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.slack;
in {
  imports = [ ];

  options = {
    modules = {
      slack = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (import (builtins.fetchGit {
        url = "git@github.snooguts.net:frederique-mittelstaedt/reddit-nix.git";
      }))

      (
        self: super: {
          slack = super.slack.overrideAttrs (old: {
            installPhase = old.installPhase + ''
              rm $out/bin/slack

              makeWrapper $out/lib/slack/slack $out/bin/slack \
              --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
              --prefix PATH : ${lib.makeBinPath [pkgs.xdg-utils]} \
              --add-flags "--enable-features=WebRTCPipeWireCapturer %U"
            '';
          });
        }
      )
    ];



    home.packages = with pkgs; [ slack ]; };
}
