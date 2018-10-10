FROM registry.docker-cn.com/library/centos
MAINTAINER wanggw
  
# SET ENVIRONMENT
ENV APP_USER=www \
BISON=bison-2.4.1 \
PHP=php-7.2.10 \
PHP_PATH=/usr/local/php \
SRC_PATH=/usr/local/src \
DOWNLOAD_SERVER=http://172.16.1.254/soft

ADD CentOS-Base.repo /etc/yum.repos.d/

# SET TIMEZONE
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo 'Asia/Shanghai' >/etc/timezone

# INSTALL PHP
RUN useradd -s /sbin/nologin $APP_USER \
\
&& yum install -y libxml2-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel libicu-devel libxslt-devel openssl-devel wget gcc glibc-headers gcc-c++ m4 make autoconf unzip \
\
&& wget -O $SRC_PATH/bison.tar.gz $DOWNLOAD_SERVER/$BISON.tar.gz \
&& cd $SRC_PATH && tar zxf bison.tar.gz && cd $BISON && ./configure && make && make install \ 
\
&& wget -O $SRC_PATH/php.tar.gz $DOWNLOAD_SERVER/$PHP.tar.gz \
&& cd $SRC_PATH && tar zxf php.tar.gz && cd $PHP \
&& ./configure --prefix=$PHP_PATH \
--with-mhash \
--with-openssl \
--with-config-file-path=$PHP_PATH/etc \
--disable-short-tags \
--enable-fpm \
--with-fpm-user=$APP_USER \
--with-fpm-group=$APP_USER \
--enable-xml \
--with-libxml-dir \
--enable-bcmath \
--enable-calendar \ 
--enable-intl \
--enable-mbstring \
--enable-pcntl \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-zip \
--enable-mbregex \
--enable-mysqlnd \
--enable-mysqlnd-compression-support \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-pdo-mysql \
--with-mysqli \
--with-gd \
--enable-ftp \
--with-curl \
--with-xsl \
--with-iconv \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--enable-sysvsem \
--enable-inline-optimization \
--with-xmlrpc \
--with-gettext \
&& make -j 4 && make install \
\
&& ln -s /usr/local/php/bin/* /usr/local/bin/ \
\
&& rm -fr $SRC_PATH/* && yum clean all 

CMD ["/bin/bash"]


