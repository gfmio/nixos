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
    dnscrypt-proxy = {
      enable = true;
      localPort = 43;
    };
    dnsmasq = {
      enable = true;
      servers = [ "127.0.0.1#43" ];
    };
  };
}
