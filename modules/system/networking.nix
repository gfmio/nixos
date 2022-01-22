#
# Networking settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.security;
in
{
  imports = [];

  options = {
    modules = {
      networking = {
        enable = mkOption { type = types.bool; default = false; };
        hostname = mkOption { type = types.str; };
        enableWireless = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # Define your hostname.
    networking.hostName = cfg.hostname;

    # Enables wireless support via wpa_supplicant.
    networking.wireless.enable = cfg.enableWireless;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking.useDHCP = false;

    networking.interfaces.enp7s0.useDHCP = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;
  };
}



