#
# .bashrc
#

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "${BASH_SOURCE-${(%):-%x}}")
# Absolute path this script is in, thus /home/user/bin
DIR=$(dirname "$SCRIPT")

source $DIR/.rc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
