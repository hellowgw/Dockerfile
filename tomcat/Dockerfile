FROM java:8u144
MAINTAINER hellowgw

ENV SRC_PATH=/usr/local/src \
    APP_PATH=/usr/local \
    TOMCAT_VERSION=apache-tomcat-7.0.91 \
    JAVA_VERSION=jdk1.8.0_144 \
    DOWNLOAD_SERVER=http://172.16.1.254/soft/java

# install tomcat
RUN cd $SRC_PATH \
    && wget $DOWNLOAD_SERVER/$TOMCAT_VERSION.tar.gz \
    && tar zxf $TOMCAT_VERSION.tar.gz -C $APP_PATH \
    && cd $APP_PATH && mv $TOMCAT_VERSION tomcat \
    && rm -fr $APP_PATH/tomcat/webapps/* \
    && mkdir -p $APP_PATH/tomcat/webapps/status/ && echo "OK" > $APP_PATH/tomcat/webapps/status/status.html \
    && find $APP_PATH/tomcat/ -maxdepth 1 -type f |xargs rm -fr \
    && cd $APP_PATH/$JAVA_VERSION/jre/lib/security \
    && rm -fr $SRC_PATH/* 

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
