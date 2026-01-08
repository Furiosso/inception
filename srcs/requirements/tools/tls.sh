#!/bin/sh

set -e

SECRETS_DIR="secrets"

#if [ ! -f "$SECRETS_DIR/inception.crt" ] || [ ! -f "$SECRETS_DIR/inception.key" ]; then
if [ ! -d "$SECRETS_DIR" ]; then
	mkdir "$SECRETS_DIR"
	openssl req -x509 -nodes \
		-newkey rsa:2048 \
  		-keyout "$SECRETS_DIR/inception.key" \
  		-out "$SECRETS_DIR/inception.crt" \
  		-subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42/CN=dagimeno.42.fr/UID=dagimeno"

	chmod 600 "$SECRETS_DIR/inception.key"
	chmod 644 "$SECRETS_DIR/inception.crt"
fi
