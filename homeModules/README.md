# Home modules

Home modules configure a particular application or set of related configs.

Home modules should not depend on a particular system architecture and should not reference any user details directly.

## Implementation

```nix
#
# MYMODULE
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.MYMODULE;
in {
  imports = [ ];

  options = {
    modules = {
      MYMODULE = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Add config here...
  };
}
```

## Usage

To use and configure a home module, add it to the home configuration of a particular user.

```nix
#
# Example home configuration
#

{ inputs, ... }@flakeContext:
{ system, lib }:
let
  homeModule = { config, pkgs, ... }: {
    imports = [
      inputs.self.homeModules.MYMODULE
    ];
    config = {
      # Add additional settings for the user here.
      # Most should be managed via other modules though
      home.stateVersion = "23.05";
      home.username = "USERNAME";
      home.homeDirectory = "/home/USERNAME";
      programs.home-manager.enable = true;
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [ ];

      modules = {
        MYMODULE = {
          enable = true;
        };
      };
    };
  };
  nixosModule = { ... }: { home-manager.users.USERNAME = homeModule; };
in ((inputs.home-manager.lib.homeManagerConfiguration {
  modules = [ homeModule ];
  pkgs = lib.getAttr system inputs.nixpkgs.legacyPackages;
}) // {
  inherit nixosModule;
})
```
