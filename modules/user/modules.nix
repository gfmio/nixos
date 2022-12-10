{ config, lib, pkgs, ... }:

{
  imports = [
    ./x.nix
    ./i3.nix
    ./i3status.nix
    ./chromium.nix
    ./firefox.nix
    ./vscode.nix
    ./sublime.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./htop.nix
    ./tmux.nix
    ./kitty.nix
    ./alacritty.nix
    # ./picom.nix
    ./networking.nix
    ./gpg.nix
    ./gnome-passwordsafe.nix
    ./sway.nix
    ./gnome-disk-utility.nix
  ];
}
