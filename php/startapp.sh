#!/bin/bash
PHP_IMAGE=php:v7.2-ext
NGX_IMAGE=nginx:v2.2
PHP_PATH=/usr/local/php
NGX_PATH=/usr/local/nginx
CONF_DIR=/data/conf
LOG_DIR=/data/log
TMP_DIR=/data/tmp
CODE_DIR=/data/wwwroot

# start FPM
docker run -it -d \
--name php-fpm \
-v $CONF_DIR/php/php-fpm.conf:$PHP_PATH/etc/php-fpm.conf:ro \
-v $CONF_DIR/php/php.ini:$PHP_PATH/etc/php.ini:ro \
-v $CONF_DIR/php/www.conf:$PHP_PATH/etc/php-fpm.d/www.conf:ro \
-v $LOG_DIR/php:$LOG_DIR/php \
-v $TMP_DIR:$TMP_DIR \
-v $CODE_DIR:$CODE_DIR \
$PHP_IMAGE 

#start NGINX
docker run -it -d \
--name nginx \
--link php-fpm \
-p 80:80 \
-p 443:443 \
-v $CONF_DIR/nginx/nginx.conf:$NGX_PATH/conf/nginx.conf:ro \
-v $CONF_DIR/nginx/vhosts:$NGX_PATH/conf/vhosts:ro \
-v $LOG_DIR/nginx:$NGX_PATH/logs \
$NGX_IMAGE
