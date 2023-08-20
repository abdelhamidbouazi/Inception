#!/bin/bash

# Change PHP-FPM listen port

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sleep 10

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Set up WordPress
cd /var/www/html
chmod 777 /var/www/html
wp core download --allow-root
cp wp-config-sample.php wp-config.php
wp config set DB_NAME $MARIADB_DATABASE --allow-root
wp config set DB_USER $MARIADB_USER --allow-root
wp config set DB_PASSWORD $MARIADB_PASSWORD --allow-root
wp config set DB_HOST "mariadb" --allow-root

wp core install  --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

# Start PHP-FPM
mkdir /run/php
/usr/sbin/php-fpm7.3 -F
