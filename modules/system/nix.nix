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
  };
}
