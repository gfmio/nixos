# Development shells

Nix development shells are preconfigured environments that can be loaded on demand.

## Implementation

```nix
#
# Example dev shell
#

{ inputs, ... }@flakeContext:
{ system }:
let
  pkgs = inputs.nixpkgs.legacyPackages."${system}";
in
pkgs.mkShell {
  packages = [ pkgs.nyancat pkgs.sl ];
}
```

## Usage

<!-- TODO: Add usage -->
