#!/bin/bash

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start

mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
                    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
                    FLUSH PRIVILEGES;"

kill `cat /var/run/mysqld/mysqld.pid`

exec "$@"
