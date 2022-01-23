{ config, lib, pkgs, ... }:

{
  imports = [
    ./x.nix
    ./i3.nix
    ./chromium.nix
    ./firefox.nix
    ./vscode.nix
    ./sublime.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./htop.nix
    ./tmux.nix
  ];
}
