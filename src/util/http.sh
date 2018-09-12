#! /bin/sh
#
# Functions for making HTTP requests
#

# Make an HTTP request using CURL
#
# $1 - The HTP verb to use for this request
# $2 - The endpoint path to request
# $3 - The data to submit (if any)
request() {
    log_debug "Calling request..."

    http_verb="$1"
    endpoint_url="$2"
    body="$3"

    # Build up the curl request
    curl_opts="-sS -v -H 'Content-Type: application/json'"
    curl_opts=$curl_opts" -H 'Authorization: $DISCORDSH_API_TOKEN'"
    curl_opts=$curl_opts" -A '$DISCORDSH_USER_AGENT'"

    if ! echo "$http_verb" | grep -E '^GET|POST|PUT|PATCH|DELETE$' 2>&1 >/dev/null
    then
        log_error "HTTP Verb \"$http_verb\" is not supported"
        exit 1
    fi

    # Adding '-X GET' raises a warning stating that it not required as it is 
    # assumed by default.
    if ! echo "$http_verb" | grep "GET" 2>&1 >/dev/null
    then
        curl_opts=$curl_opts" -X $http_verb"
    fi

    if [ ! -z "$DISCORDSH_STDIN" ]
    then
        curl_opts=$curl_opts" -d '$DISCORDSH_STDIN'"
    fi

    # Do not display the users auth token in log messages
    log_debug "Using curl options: "$(echo $curl_opts \
        | sed "s/Authorization: [^']*/Authorization: *****/")

    curl_stderr_file="$(mktemp)"
    response_stdout=$(eval curl $curl_opts "$DISCORDSH_API_BASE_URL$endpoint_url" 2>$curl_stderr_file)
    response_stderr="$(cat "$curl_stderr_file")"
    rm -f "$curl_stderr_file"

    log_debug "Response stdout: $response_stdout"
    log_multiline log_debug "$response_stderr" "Response stderr:"

    # Transform the response headers into an array
    response_headers=$(echo "$response_stderr" \
        | grep -E '^<' \
        | sed 's/< //')
    
    # TODO - Handle rate limiting

    echo "$response_stdout" | jq
}

# Return the value for a requested response header
#
# $1 - The response header we want the value for
# $2 - String containing all headings with 1 heading per line
get_response_header() {
    echo "$2" | grep -E "^$1:" | sed "s/^[^:]*: //"
}