#!/bin/bash

# Update the bind address to allow connections from any IP
# Start the MariaDB service

service mysql start

sleep 10
# # Use the root user and password to create the database and user
mariadb -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY $MARIADB_ROOT_PASSWORD;"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
