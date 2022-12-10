#
# Nix settings
#

{ config, pkgs, lib, ... }:

with lib;

{
  imports = [];
  options = {};
  config = {
    nixpkgs.config.allowUnfree = true;

    system.autoUpgrade.enable = true;

    nix = {
      gc = {
        # Automatically run the garbage collector
        automatic = false;
        dates = "12:45";
      };

      optimise = {
        # Automatically run the nix store optimiser
        automatic = false;
        dates = [ "12:55" ];
      };

      settings = {
        # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
        auto-optimise-store = true;
        # maximum number of concurrent tasks during one build
        cores = 4;
        # maximum number of jobs that Nix will try to build in parallel
        # "auto" is broken: https://github.com/NixOS/nixpkgs/issues/50623
        max-jobs = 4;
        # perform builds in a sandboxed environment
        sandbox = true;
      };
    };

    # Add the NixOS Manual on virtual console 8
    # services.nixosManual.showManual = true;
  };
}
