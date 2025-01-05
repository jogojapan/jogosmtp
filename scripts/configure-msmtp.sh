#!/bin/sh

# Create msmtp config file
cat > /etc/msmtprc << EOF
account default
host ${SES_SMTP_HOST}
port ${SES_SMTP_PORT}
domain ${SES_DOMAIN}
maildomain ${SES_MAILDOMAIN}
user ${SES_SMTP_USER}
password ${SES_SMTP_PW}
tls on
tls_starttls on
tls_certcheck on
auth on
EOF

# Set proper permissions for the config file
chmod 600 /etc/msmtprc

# Start the SMTP proxy
exec /usr/local/bin/start-smtp-proxy.sh
