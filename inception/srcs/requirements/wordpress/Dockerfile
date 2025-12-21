#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update \
	&& apt-get install -y \
	curl \
	ca-certificates \
	php8.2 \
	php8.2-fpm \
	php8.2-mysql \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/* 

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh

RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
CMD ["/usr/sbin/php-fpm8.2"]
