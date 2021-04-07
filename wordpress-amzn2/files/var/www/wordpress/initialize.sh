#!/bin/bash

## !!!!!! /var/www/html/wordpress が上書きされます !!!!!!

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

source ./env.sh

cd /var/www/html
wget https://ja.wordpress.org/wordpress-5.3.2-ja.tar.gz
tar xzvf wordpress-5.3.2-ja.tar.gz -C /var/www/html
rm -f wordpress-5.3.2-ja.tar.gz
cp -f $SRC_WP_INIT_PATH/wp-config.php /var/www/html/wordpress/wp-config.php
# sed -i -e "s/<DB_HOST>/$DB_HOST/g" /var/www/html/wordpress/wp-config.php
# sed -i -e "s/<DB_NAME>/$DB_NAME/g" /var/www/html/wordpress/wp-config.php
# sed -i -e "s/<DB_USER>/$DB_USER/g" /var/www/html/wordpress/wp-config.php
# ESCAPED_DB_PASSWORD=`echo ${DB_PASSWORD//\//\\/}`
# sed -i -e "s/<DB_PASSWORD>/$ESCAPED_DB_PASSWORD/g" /var/www/html/wordpress/wp-config.php
sed -i -e "s/<EMAIL_FROM_ADDRESS>/$EMAIL_FROM_ADDRESS/g" /var/www/html/wordpress/wp-config.php
sed -i -e "s/<EMAIL_FROM_NAME>/$EMAIL_FROM_NAME/g" /var/www/html/wordpress/wp-config.php
cp -f $SRC_WP_INIT_PATH/wp-settings.php /var/www/html/wordpress/wp-settings.php
find /var/www/html/wordpress -type d -exec chmod 705 {} \;
find /var/www/html/wordpress -type f -exec chmod 604 {} \;
chmod 400 /var/www/html/wordpress/wp-config.php
chown -R nginx:nginx /var/www/html
