#!/bin/sh

echo "----- Setting MariaDB -----"

# Start the DB if it doesn’t exist
 if ! pgrep mariadbd > /dev/null; then
	service mariadb start
	sleep 5
fi

#--------------mariadb config--------------#
mariadb -u root << EOF
	CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;
	CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';
	FLUSH PRIVILEGES;
EOF

#mariadb -u root -p -e "SHOW DATABASES;"

#--------------mariadb restart--------------#
mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'