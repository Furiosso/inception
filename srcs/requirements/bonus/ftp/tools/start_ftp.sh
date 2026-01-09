#!/bin/sh

if ! id "$FTP_USER" >/dev/null 2>&1; then
    adduser --disabled-password --gecos "" $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

chown -R $FTP_USER:$FTP_USER /var/www/wordpress
chmod -R u+rwX /var/www/wordpress

exec "$@"
