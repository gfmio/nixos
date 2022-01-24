#
# .bash_logout
#

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "${BASH_SOURCE-${(%):-%x}}")
# Absolute path this script is in, thus /home/user/bin
DIR=$(dirname "$SCRIPT")

source $DIR/.logout
