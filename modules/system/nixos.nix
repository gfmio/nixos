#
# Core nixos settings
#

{ config, pkgs, lib, ... }:

with lib;

{
  imports = [];
  options = {};
  config = {
    nixpkgs.config.allowUnfree = true;
  };
}
