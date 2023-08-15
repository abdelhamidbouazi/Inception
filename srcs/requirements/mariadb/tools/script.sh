#!/bin/bash

# Update MySQL/MariaDB config to allow remote connections
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Start MySQL/MariaDB service
service mysql start

# Create the database and grant privileges
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
                    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
                    FLUSH PRIVILEGES;"

# Kill the running MySQL/MariaDB instance
kill $(cat /var/run/mysqld/mysqld.pid)

# Execute the remaining command (if any)
exec "$@"
