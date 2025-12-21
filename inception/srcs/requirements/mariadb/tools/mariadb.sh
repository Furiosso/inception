#!/bin/sh
set -e

# Crear directorio del socket
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Inicializar base de datos si está vacía
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb_install_db --user=mysql --datadir=/var/lib/mysql

    # Arrancar MariaDB temporal en background
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
    pid="$!"

    # Esperar a que el servidor esté listo
    until mysqladmin ping --socket=/run/mysql/mysqld.sock --silent; do
        sleep 1
    done

    # Configuración inicial
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    # Parar el servidor temporal
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

    wait "$pid"
fi

# Arranque FINAL en foreground
exec "$@" --user=mysql --datadir=/var/lib/mysql
