#
# DNS / dnscrypt / dnsmasq settings
#

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.dns;
in
{
  imports = [];

  options = {
    modules = {
      dns = {
        enable = mkOption { type = types.bool; default = false; };
      };
    };
  };

  config = mkIf cfg.enable {
    # DNSCrypt + DNSMasq
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/2.1.1/dnscrypt-proxy/example-dnscrypt-proxy.toml
    services.dnscrypt-proxy2 = {
      enable = true;
      # localPort = 43;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        # server_names = [ ... ];
      };
    };
    services.dnsmasq = {
      enable = true;
      servers = [ "127.0.0.1#43" ];
    };

    networking = {
      nameservers = [ "127.0.0.1" "::1" ];
      resolvconf.enable = false;
      # If using dhcpcd:
      dhcpcd.extraConfig = "nohook resolv.conf";
      # If using NetworkManager:
      networkmanager.dns = "none";
    };

  };
}
