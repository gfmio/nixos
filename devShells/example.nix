#
# example dev shell
#

{ inputs, ... }@flakeContext:
{ system }:
let
  pkgs = inputs.nixpkgs.legacyPackages."${system}";
in
pkgs.mkShell {
  packages = [ pkgs.nyancat pkgs.sl ];
}
