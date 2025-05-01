#!/bin/sh
set -e

echo "--- WordPress Setup ---"

# Wait for MariaDB to be ready
echo "⏳ Waiting for MariaDB..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
	sleep 1
done
echo "✅ MariaDB is up."

# Download WP-CLI if not already present
if ! command -v wp >/dev/null 2>&1; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

# Setup WordPress directory
mkdir -p /var/www/wordpress
cd /var/www/wordpress

# Download and configure WordPress
if [ ! -f wp-config.php ]; then
	echo "⬇️  Downloading WordPress..."
	wp core download --allow-root

	echo "⚙️  Generating wp-config.php..."
	wp core config \
		--dbhost=$WORDPRESS_DB_HOST \
		--dbname=$WORDPRESS_DB_NAME \
		--dbuser=$WORDPRESS_DB_USER \
		--dbpass=$WORDPRESS_DB_PASSWORD \
		--allow-root

	echo "🛠  Installing WordPress..."
	wp core install \
		--url=$DOMAIN_NAME \
		--title="INCEPTION" \
		--admin_user=$WP_ADMIN_NAME \
		--admin_email=$WP_ADMIN_EMAIL \
		--admin_password=$WP_ADMIN_PASS \
		--skip-email \
		--allow-root

	echo "👤 Creating additional user..."
	wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" \
		--user_pass="$WP_USER_PASS" \
		--allow-root
else
	echo "✅ WordPress already set up. Skipping install..."
fi

# Final permissions
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Change PHP-FPM to listen on TCP instead of a Unix socket
sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Ensure correct ownership (these may already be present)
sed -i 's|^listen.owner = .*|listen.owner = www-data|' /etc/php/8.2/fpm/pool.d/www.conf
sed -i 's|^listen.group = .*|listen.group = www-data|' /etc/php/8.2/fpm/pool.d/www.conf
sed -i 's|^user = .*|user = www-data|' /etc/php/8.2/fpm/pool.d/www.conf
sed -i 's|^group = .*|group = www-data|' /etc/php/8.2/fpm/pool.d/www.conf

echo "🚀 WordPress container is running..."
exec php-fpm8.2 -F
