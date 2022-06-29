#!/bin/sh

# init nginx
if [ ! -d "/var/tmp/nginx/client_body" ]; then
  mkdir -p /run/nginx /var/tmp/nginx/client_body
  chown dev:dev -R /run/nginx /var/tmp/nginx/
fi
