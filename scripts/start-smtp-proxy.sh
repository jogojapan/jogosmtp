#!/bin/sh

# Default to port 1025 if SMTP_PROXY_PORT is not set
SMTP_PROXY_PORT=${SMTP_PROXY_PORT:-1025}

echo "Starting SMTP proxy on port ${SMTP_PROXY_PORT}"

# Start socat to listen for SMTP connections and pipe them to msmtp
exec socat \
  TCP4-LISTEN:1025,fork,reuseaddr,crlf \
  EXEC:"msmtp -t 30 --read-envelope-from --read-recipients"
