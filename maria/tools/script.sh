#!/bin/bash

echo "Initializing database..."

# Update the bind address to allow connections from any IP
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Start the MariaDB service
service mysql start

# Use the root user and password to create the database and user
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY \`$MARIADB_ROOT_PASSWORD\`";
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\`;"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'%';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

kill `cat /var/run/mysqld/mysqld.pid`

# echo "Database initialized!"

# Start the CMD specified in the Dockerfile (e.g., your application)
exec "$@"
