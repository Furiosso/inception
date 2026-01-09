#!/bin/sh

set -e

if [ ! -f "/usr/local/bin/wp" ]; then
	curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x /usr/local/bin/wp
fi

until mysqladmin ping \
	-h mariadb \
	-u"$MYSQL_USER" \
	-p"$MYSQL_PASSWORD" \
	--silent
do
	sleep 1
done

if [ ! -f "$WP_PATH/wp-load.php" ]; then
	mkdir -p "$WP_PATH"
	chown -R www-data:www-data "$WP_PATH"
    wp core download \
        --path="$WP_PATH" \
        --allow-root
fi

if ! wp core is-installed --allow-root --path=$WP_PATH ; then
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path=$WP_PATH

	wp core install \
		--path=$WP_PATH \
		--url="https://dagimeno.42.fr" \
		--title="inception" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root

	wp user create \
		--path=$WP_PATH \
		"$WP_USER" \
		"$WP_USER_EMAIL" \
		--user_pass="$WP_USER_PASSWORD" \
		--role=author \
		--allow-root

	wp plugin install redis-cache --activate --path=$WP_PATH --allow-root
	wp config set WP_REDIS_HOST \"redis\" --type=constant --raw --path=$WP_PATH --allow-root
    wp config set WP_REDIS_PORT \"6379\" --type=constant --raw --path=$WP_PATH --allow-root
    wp config set WP_REDIS_PREFIX \"inception\" --type=constant --raw --path=$WP_PATH --allow-root
    wp config set WP_REDIS_DATABASE \"0\" --type=constant --raw --path=$WP_PATH --allow-root
    wp config set WP_REDIS_TIMEOUT \"1\" --type=constant --raw --path=$WP_PATH --allow-root
    wp config set WP_REDIS_READ_TIMEOUT \"1\" --type=constant --raw --path=$WP_PATH --allow-root
	wp redis enable --path=$WP_PATH --allow-root
fi

mkdir -p /run/php

exec "$@" -F
