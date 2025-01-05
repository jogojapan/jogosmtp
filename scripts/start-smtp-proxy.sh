#!/bin/sh

# Default to port 1025 if SMTP_PROXY_PORT is not set
SMTP_PROXY_PORT=${SMTP_PROXY_PORT:-1025}

echo "Starting SMTP proxy on port ${SMTP_PROXY_PORT}"

# Start socat to listen for SMTP connections and pipe them to msmtp
exec socat \
    TCP4-LISTEN:${SMTP_PROXY_PORT},fork,reuseaddr \
    EXEC:"/usr/bin/msmtp --read-envelope-from --read-recipients"
