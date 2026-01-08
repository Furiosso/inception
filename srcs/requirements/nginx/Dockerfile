#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends nginx \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /var/run/nginx /var/www/wordpress \
	&& chmod 755 /var/www/wordpress \
	&& chown -R www-data:www-data /var/www/wordpress

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx"]
