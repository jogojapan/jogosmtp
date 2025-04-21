# jogosmtp

A small container based on alpine and msmtp that enables sending email
through SMTP. It's particularly suitable when you have an email set up
with Amazon SES.

It starts an SMTP service based on `msmtp`. It's crude, but you can
use it to send email directly through it:

``` bash
echo "Test email body" | msmtp --debug --from=sender@domain.com recipient@example.com
```

The example docker-compose.yml maps and exposes the port for that, so
in theory you can use this to send email from other containers,
too. That part is not quite working currently.

It also provides the Perl-based swaks command line tool:

``` bash
swaks --from sender@domain.com --to recipient@example.com --h-Subject "Quick Test" --body "This is a very nice little email test."
```

My standard use for this is that I use the image as a base image for
other things, so I send email only from inside the container, e.g. by
calling swaks.

## Prerequisites

You need to set environment variables with credentials, e.g. for
Amazon SES:

```
SMTP_PROXY_PORT=1025
SES_SMTP_HOST=email-smtp.REGION.amazonaws.com
SES_SMTP_PORT=587
SES_DOMAIN=domain.com
SES_MAILDOMAIN=mail.domain.com
SES_SMTP_USER=myuser
SES_SMTP_PW=mypasswd
SES_SENDER_MAIL_ADDRESS=sender@domain.com
```

The `$SES_SENDER_MAIL_ADDRESS` serves as the default from-address. It
must be an address that is registered as an acceptable sender address
with Amazon SES. (You can use other SMETP services, too, and for those
this may not be a requirement.)
