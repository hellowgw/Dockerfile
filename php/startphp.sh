#!/bin/bash
IMAGE=php:v7.2-ext
PHP_PATH=/usr/local/php
CONF_DIR=/data/conf/php
LOG_DIR=/data/log/php
TMP_DIR=/data/tmp
CODE_DIR=/data/wwwroot
docker run -it -d \
--name php-fpm \
-v $CONF_DIR/php-fpm.conf:$PHP_PATH/etc/php-fpm.conf:ro \
-v $CONF_DIR/php.ini:$PHP_PATH/etc/php.ini:ro \
-v $CONF_DIR/www.conf:$PHP_PATH/etc/php-fpm.d/www.conf:ro \
-v $LOG_DIR:$LOG_DIR \
-v $TMP_DIR:$TMP_DIR \
-v $CODE_DIR:$CODE_DIR \
$IMAGE 
