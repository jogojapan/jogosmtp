FROM alpine:latest

# Install required packages
RUN apk update && \
    apk add --no-cache \
        socat \
        msmtp \
        perl \
        perl-net-ssleay \
        perl-io-socket-ssl \
        ca-certificates \
        mailx \
    && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        swaks

# Verify installations
RUN socat -V && \
    msmtp --version && \
    swaks --version

# Copy our configuration and startup scripts
COPY scripts/configure-msmtp.sh /usr/local/bin/
COPY scripts/start-smtp-proxy.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/configure-msmtp.sh /usr/local/bin/start-smtp-proxy.sh

# Expose SMTP port (default 1025, can be overridden)
EXPOSE 1025

# Set the script as the entrypoint
ENTRYPOINT ["/usr/local/bin/configure-msmtp.sh"]
