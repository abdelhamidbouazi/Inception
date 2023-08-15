#!/bin/bash

# Update PHP-FPM configuration to use TCP socket
sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf

# Download and install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Navigate to the website directory
cd /var/www/html

# Set appropriate permissions
chmod 777 /var/www/html

# Download WordPress core
wp core download --allow-root

# Create a wp-config.php file
cp wp-config-sample.php wp-config.php

# Configure WordPress database settings
wp config set DB_NAME "wordpress" --allow-root
wp config set DB_USER "abouazi" --allow-root
wp config set DB_PASSWORD "abouazi0000" --allow-root
wp config set DB_HOST "mariadb" --allow-root

# Configure caching settings
wp config set WP_REDIS_HOST "redis-cache" --allow-root
wp config set WP_REDIS_PORT "6379" --allow-root
wp config set WP_CACHE "true" --allow-root

# Install and activate the Redis Cache plugin
wp plugin install redis-cache --activate --allow-root

# Install WordPress and set up admin user
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root

# Create an additional user with the 'author' role
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# Enable Redis caching
wp redis enable --allow-root

# Create directory for PHP-FPM
mkdir /run/php

# Start PHP-FPM service
/usr/sbin/php-fpm7.3 -F
