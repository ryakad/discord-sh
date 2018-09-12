#! /bin/sh -
#
# Functions for color formatting
#

# Setup base colors, allowing them to be overridden by setting these variables globally.
test -z $DISCORDSH_COLOR_ERROR && DISCORDSH_COLOR_ERROR="\033[1;31m" # red
test -z $DISCORDSH_COLOR_WARNING && DISCORDSH_COLOR_WARNING="\033[0;33m" # yellow
test -z $DISCORDSH_COLOR_SUCCESS && DISCORDSH_COLOR_SUCCESS="\033[0;36m" # cyan
test -z $DISCORDSH_COLOR_INFO && DISCORDSH_COLOR_INFO="" # off by default
test -z $DISCORDSH_COLOR_DEBUG && DISCORDSH_COLOR_DEBUG="" # off by default

color_reset="\033[0m"

log_error() {
    echo -e "$DISCORDSH_COLOR_ERROR[ERROR] $@$color_reset" 1>&2
}

log_warning() {
    echo -e "$DISCORDSH_COLOR_WARNING[WARNING] $@$color_reset" 1>&2
}

log_info() {
    echo -e "$DISCORDSH_COLOR_INFO[INFO] $@$color_reset" 1>&2
}

log_debug() {
    echo -e "$DISCORDSH_COLOR_DEBUG[DEBUG] $@$color_reset" 1>&2
}

log_success() {
    echo -e "$DISCORDSH_COLOR_SUCCESS[SUCCESS] $@$color_reset" 1>&2
}

# Function for multiline logging to allow prefixing each line with the log 
# level for easier parsing of output.
#
# $1 - The logging function to use
# $2 - A string containing the multiline output
# $3 - An optional heading for the log. This will be printed before writing
#      the multiline output
log_multiline() {
    [ ! -z "$3" ] && eval $1 "$3" # If a header is provided log that first
    while read -r line
    do
        eval $1 $(printf "    %q" "$line")
    done <<< "$2"
}
