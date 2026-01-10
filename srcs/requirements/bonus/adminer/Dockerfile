#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://www.adminer.org/latest.php -O adminer.php

EXPOSE 8080

ENTRYPOINT [ "php" ]
CMD ["-S", "0.0.0.0:8080", "adminer.php"]