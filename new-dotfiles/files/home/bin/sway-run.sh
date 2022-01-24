#!/bin/sh

source $HOME/.rc
source $HOME/.profile

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

source $HOME/bin/wayland-enablement.sh

systemd-cat --identifier=sway sway --my-next-gpu-wont-be-nvidia $@

