#!/bin/bash

SRC_FILES_PATH=/tmp/files
SRC_WP_INIT_PATH=/root/wp-init

sudo yum update -y
sudo yum install -y jq nkf
sudo amazon-linux-extras install -y epel
sleep 30

# timezone
sudo timedatectl set-timezone Asia/Tokyo

# locale
sudo localectl set-locale LANG=ja_JP.UTF-8
sudo localectl set-keymap jp106

# nginx
sudo cp -f $SRC_FILES_PATH/etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo
sudo yum install -y nginx
sudo cp -f $SRC_FILES_PATH/etc/nginx/nginx.conf /etc/nginx/nginx.conf
sudo systemctl enable nginx.service

# php
# PHP拡張は以下ページで推奨されているもののうち不足しているものをインストール
# https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions
sudo rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
sudo yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo amazon-linux-extras install -y php7.4
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install -y --enablerepo=remi-php74 php-opcache php-apcu php-xml php-mbstring php-mysqli php-zip php-gd php-mcrypt libsodium

sudo cp -f $SRC_FILES_PATH/etc/php.ini /etc/php.ini
sudo cp -f $SRC_FILES_PATH/etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf
sudo cp -f $SRC_FILES_PATH/etc/nginx/default.d/php.conf /etc/nginx/default.d/php.conf
sudo cp -f $SRC_FILES_PATH/etc/logrotate.d/php-fpm /etc/logrotate.d/php-fpm
sudo systemctl enable php-fpm.service

# Wordpress 初期化ファイル群
sudo mkdir $SRC_WP_INIT_PATH
sudo cp -f /tmp/env.sh $SRC_WP_INIT_PATH/env.sh
sudo cp -f $SRC_FILES_PATH$SRC_WP_INIT_PATH/* $SRC_WP_INIT_PATH
sudo chown root:root -R $SRC_WP_INIT_PATH
sudo ls -l $SRC_WP_INIT_PATH
sudo chmod +x $SRC_WP_INIT_PATH/initialize.sh

# mail for notificaton (relay postfix to Amazon SES)
## https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/postfix.html
sudo yum install -y postfix mailx
sudo postconf -e "relayhost = [email-smtp.us-east-1.amazonaws.com]:587" \
"smtp_sasl_auth_enable = yes" \
"smtp_sasl_security_options = noanonymous" \
"smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" \
"smtp_use_tls = yes" \
"smtp_tls_security_level = encrypt" \
"smtp_tls_note_starttls_offer = yes" \
"sender_canonical_maps = hash:/etc/postfix/canonical"

sudo cp -f $SRC_FILES_PATH/etc/postfix/canonical /etc/postfix/canonical
sudo sed -i -e "s/<EMAIL_FROM_ADDRESS>/$EMAIL_FROM_ADDRESS/g" /etc/postfix/canonical
sudo postmap /etc/postfix/canonical

sudo cp -f $SRC_FILES_PATH/etc/postfix/sasl_passwd /etc/postfix/sasl_passwd
ESCAPED_SMTP_PASSWORD=`echo ${SMTP_PASSWORD//\//\\\\/}`
sudo sed -i -e "s/<SMTP_USERNAME>/$SMTP_USERNAME/g" /etc/postfix/sasl_passwd
sudo sed -i -e "s/<SMTP_PASSWORD>/$ESCAPED_SMTP_PASSWORD/g" /etc/postfix/sasl_passwd
sudo chown root:root /etc/postfix/sasl_passwd
sudo chmod 0600 /etc/postfix/sasl_passwd
sudo postmap hash:/etc/postfix/sasl_passwd
sudo postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt'
sudo postfix reload

# security patch
sudo yum install -y yum-cron
sudo cp -f $SRC_FILES_PATH/etc/yum/yum-cron-hourly.conf /etc/yum/yum-cron-hourly.conf
sudo sed -i -e "s/<EMAIL_FROM_ADDRESS>/$EMAIL_FROM_ADDRESS/g" /etc/yum/yum-cron-hourly.conf
sudo sed -i -e "s/<EMAIL_TO_ADDRESS>/$EMAIL_TO_ADDRESS/g" /etc/yum/yum-cron-hourly.conf
sudo systemctl enable yum-cron
