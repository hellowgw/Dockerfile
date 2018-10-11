FROM hellowgw/centos7
MAINTAINER hellowgw

ENV SRC_PATH /data/src
ENV APP_PATH /data/application
ENV NGX_VERSION tengine-2.2.0
ENV OPENSSL_VERSION openssl-1.0.2h
ENV PCRE_VERSION pcre-8.38
ENV NGX_CACHE_PURGE_VERSION ngx_cache_purge-2.3
ENV ZLIB_VERSION zlib-1.2.11
ENV LuaJIT_VERSION LuaJIT-2.0.5
ENV NGX_DEVEL_KIT_VERSION ngx_devel_kit-0.3.0
ENV Lua_NGX_MODULE_VERSION lua-nginx-module-0.10.6



COPY soft /data/src/

# install LuaJIT
RUN cd $SRC_PATH/$LuaJIT_VERSION \
    && make PREFIX=$APP_PATH/$LuaJIT_VERSION \
    && make install PREFIX=$APP_PATH/$LuaJIT_VERSION \
    && ln -s $APP_PATH/$LuaJIT_VERSION/lib/libluajit-5.1.so.2.0.5 /usr/lib64/libluajit-5.1.so.2 \
    && ln -s $APP_PATH/$LuaJIT_VERSION/lib/libluajit-5.1.so.2.0.5 /usr/lib/libluajit-5.1.so.2 \
    && echo "export LUAJIT_LIB=$APP_PATH/$LuaJIT_VERSION/lib" >> /etc/profile \
    && echo "export LUAJIT_INC=$APP_PATH/$LuaJIT_VERSION/include/luajit-2.0" >> /etc/profile \
    && source /etc/profile

# install nginx
RUN cd $SRC_PATH/$NGX_VERSION \
    && export LUAJIT_LIB=$APP_PATH/$LuaJIT_VERSION/lib \
    && export LUAJIT_INC=$APP_PATH/$LuaJIT_VERSION/include/luajit-2.0 \
    && ./configure --prefix=$APP_PATH/$NGX_VERSION \
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
    && make && make install \
    && chown -R www.www $APP_PATH/$NGX_VERSION \
    && cp $SRC_PATH/nginx.conf $APP_PATH/$NGX_VERSION/conf \
    && ln -s $APP_PATH/$NGX_VERSION /usr/local/nginx \
    && rm -fr $SRC_PATH

EXPOSE 80 443

CMD ["/usr/local/nginx/sbin/nginx"]

