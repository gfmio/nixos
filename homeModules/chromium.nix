#
# chromium home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.chromium;
in {
  imports = [ ];

  options = {
    modules = {
      chromium = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
        { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # DuckDuckGo Privacy Essentials
        { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google Docs Offline
        { id = "chphlpgkkbolifaimnlloiipkdnihall"; } # OneTab
        { id = "noonakfaafcdaagngpjehilgegefdima"; } # Vimeo repeat & speed
      ];
    };
  };
}
