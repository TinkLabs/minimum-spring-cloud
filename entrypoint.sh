#!/bin/sh

set -e

consul=$CONSUL_ADDRESS
if [ -z "$CONSUL_ADDRESS" ]; then
    consul=`wget --timeout=5 --tries=2 -qO- http://169.254.169.254/latest/meta-data/local-ipv4`
    echo "host ip :$consul"
    export CONSUL_ADDRESS=${consul}
else
    echo "consul_address already defined: $CONSUL_ADDRESS"
fi

exec java -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar
