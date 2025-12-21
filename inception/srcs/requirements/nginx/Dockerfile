#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends nginx \
	&& rm -rf /var/lib/apt/lists/* \
#	&& mkdir -p /etc/nginx/ssl \
#	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42/CN=dagimeno.42.fr/UID=dagimeno" \
	&& mkdir -p /var/run/nginx \
	&& chmod 755 /var/www/html \
	&& chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx"]
