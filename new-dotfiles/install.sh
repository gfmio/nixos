#!/bin/sh

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "${BASH_SOURCE-${(%):-%x}}")
# Absolute path this script is in, thus /home/user/bin
DIR=$(dirname "$SCRIPT")

TARGET=$HOME

symlink() {
    SRC=$1/$2
    DEST=$3/$2
    rm -rf $DEST
    # mv $DEST $DEST.bak
    ln -s $SRC $DEST
}

symlink_home() {
    symlink $DIR/files/home $1 $TARGET
}

# rm -rf $HOME/.config/alacritty2
# ln -s $DIR/home/.config/alacritty $HOME/.config/alacritty2

symlink_home .config/alacritty
symlink_home .config/autostart
symlink_home .config/i3
symlink_home .config/i3status
symlink_home .config/kanshi
symlink_home .config/picom
symlink_home .config/sway
symlink_home .config/systemd
symlink_home .config/xdg-desktop-portal-wlr
symlink_home .config/chromium-flags.conf

symlink_home .bash_logout
symlink_home .bash_profile
symlink_home .bashrc

symlink_home .zlogin
symlink_home .zlogout
symlink_home .zprofile
symlink_home .zshenv
symlink_home .zshrc

symlink_home .gitconfig

symlink_home .screenrc
symlink_home .xinitrc
symlink_home .Xclients
symlink_home .Xresources
symlink_home .Xsession
symlink_home .xsessionrc

install -d files/home/.local/share/fonts/ttf/some-font $HOME/.local/share/fonts/ttf/some-font
sudo install -m0755 -D files/usr/local/bin/sway-service /usr/local/bin/sway-service
sudo install -m0644 -D files/usr/share/wayland-sessions/sway-systemd.desktop /usr/share/wayland-sessions/sway-systemd.desktop

