#
# Networking settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.networking;
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

    networking.networkmanager.enable = true;

    # Simple stateful dual-stack firewall
    networking.firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      logRefusedConnections = true;
      checkReversePath = false; # for libvirtd
    };

    #networking.search = ["oxalide.local"];
    #networking.nameservers = ["192.168.3.2" "89.185.39.94" "176.103.130.130" "1.0.0.1"];
    # The list of nameservers. It can be left empty if it is auto-detected through DHCP.
    #networking.nameservers = [ "1.0.0.1" "1.1.1.1" ];

    # Network usage statistics
    services.vnstat.enable = true;

    networking.wicd.enable = false;
  };
}



