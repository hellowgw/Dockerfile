FROM registry.docker-cn.com/library/centos
MAINTAINER hellowgw

ENV APP_USER=www \
SRC_PATH=/usr/local/src \
APP_PATH=/usr/local \
NGX_VERSION=tengine-2.2.0 \
OPENSSL_VERSION=openssl-1.0.2h \
PCRE_VERSION=pcre-8.38 \
NGX_CACHE_PURGE_VERSION=ngx_cache_purge-2.3 \
ZLIB_VERSION=zlib-1.2.11 \
LuaJIT_VERSION=LuaJIT-2.0.5 \
NGX_DEVEL_KIT_VERSION=ngx_devel_kit-0.3.0 \
Lua_NGX_MODULE_VERSION=lua-nginx-module-0.10.6 \
DOWNLOAD_SERVER=http://172.16.1.254/soft/nginx

# SET TIMEZONE
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo 'Asia/Shanghai' >/etc/timezone

ADD CentOS-Base.repo /etc/yum.repos.d/

RUN useradd -s /sbin/nologin $APP_USER \
&& yum install -y wget gcc glibc-headers gcc-c++ m4 make autoconf unzip \
&& cd $SRC_PATH \
&& wget $DOWNLOAD_SERVER/$NGX_VERSION.tar.gz && tar zxf $NGX_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/$OPENSSL_VERSION.tar.gz && tar zxf $OPENSSL_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/$PCRE_VERSION.tar.gz && tar zxf $PCRE_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/$NGX_CACHE_PURGE_VERSION.tar.gz && tar zxf $NGX_CACHE_PURGE_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/$ZLIB_VERSION.tar.gz && tar zxf $ZLIB_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/$LuaJIT_VERSION.tar.gz && tar zxf $LuaJIT_VERSION.tar.gz \
&& wget $DOWNLOAD_SERVER/v0.3.0.tar.gz && tar zxf v0.3.0.tar.gz \
&& wget $DOWNLOAD_SERVER/v0.10.6.tar.gz && tar zxf v0.10.6.tar.gz \
# install LuaJIT
    && cd $SRC_PATH/$LuaJIT_VERSION \
    && make PREFIX=$APP_PATH/$LuaJIT_VERSION \
    && make install PREFIX=$APP_PATH/$LuaJIT_VERSION \
    && ln -s $APP_PATH/$LuaJIT_VERSION/lib/libluajit-5.1.so.2.0.5 /usr/lib64/libluajit-5.1.so.2 \
    && ln -s $APP_PATH/$LuaJIT_VERSION/lib/libluajit-5.1.so.2.0.5 /usr/lib/libluajit-5.1.so.2 \
    && echo "export LUAJIT_LIB=$APP_PATH/$LuaJIT_VERSION/lib" >> /etc/profile \
    && echo "export LUAJIT_INC=$APP_PATH/$LuaJIT_VERSION/include/luajit-2.0" >> /etc/profile \
    && source /etc/profile \
# install nginx
    && cd $SRC_PATH/$NGX_VERSION \
    && export LUAJIT_LIB=$APP_PATH/$LuaJIT_VERSION/lib \
    && export LUAJIT_INC=$APP_PATH/$LuaJIT_VERSION/include/luajit-2.0 \
    && ./configure --prefix=$APP_PATH/nginx \
       --user=www --group=www \
       --with-openssl=$SRC_PATH/$OPENSSL_VERSION \
       --with-pcre=$SRC_PATH/$PCRE_VERSION \
       --with-zlib=$SRC_PATH/$ZLIB_VERSION \
       --with-http_stub_status_module \
       --with-http_ssl_module \
       --add-module=$SRC_PATH/$NGX_CACHE_PURGE_VERSION \
       --add-module=$SRC_PATH/$NGX_DEVEL_KIT_VERSION \
       --add-module=$SRC_PATH/$Lua_NGX_MODULE_VERSION \
       --with-ld-opt="-Wl,-rpath,$APP_PATH/$NGX_VERSION/lib" \
    && make && make install && mkdir -p $APP_PATH/nginx/conf/vhosts \
    && yum clean all && rm -fr $SRC_PATH/*

EXPOSE 80 443

CMD ["/usr/local/nginx/sbin/nginx"]

