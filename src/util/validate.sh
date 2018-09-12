#! /bin/sh -

validate_opts() {
    variable="$1"
    opts="$2"

    if [ -z "${!variable}" ]
    then
        log_error "Missing required option ${opts}"
        exit 1
    fi
}

validate_opts_guild() {
    validate_opts "OPTS_GUILD" "-g|--guild"
}

validate_opts_user() {
    validate_opts "OPTS_USER" "-u|--user"
}

validate_opts_channel() {
    validate_opts "OPTS_CHANNEL" "-c|--channel"
}

validate_opts_webhook() {
    validate_opts "OPTS_WEBHOOK" "-w|--webhook"
}

validate_opts_integration() {
    validate_opts "OPTS_INTEGRATION" "-i|--integration"
}

validate_opts_emoji() {
    validate_opts "OPTS_EMOJI" "-e|--emoji"
}