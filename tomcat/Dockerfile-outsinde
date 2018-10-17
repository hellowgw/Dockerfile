FROM hellowgw/centos7
MAINTAINER hellowgw

ENV SRC_PATH /data/src
ENV APP_PATH /data/application
ENV JAVA_VERSION jdk-7u79-linux-x64.rpm
ENV TOMCAT_VERSION apache-tomcat-7.0.61

COPY soft /data/src/

# install java
RUN rpm -ivh $SRC_PATH/$JAVA_VERSION \
    && echo "export JAVA_HOME=/usr/java/jdk1.7.0_79" >> /etc/profile \
    && echo "export JAVA_BIN=/usr/java/jdk1.7.0_79/bin" >> /etc/profile \
    && echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile \
    && echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile \
    && echo "export JAVA_HOME JAVA_BIN PATH CLASSPATH" >> /etc/profile

# install tomcat
RUN cp -fr $SRC_PATH/$TOMCAT_VERSION $APP_PATH\
    && cp -fr $SRC_PATH/catalina.sh $APP_PATH/$TOMCAT_VERSION/bin/ \
    && ln -s $APP_PATH/$TOMCAT_VERSION /usr/local/tomcat \
    && rm -fr $SRC_PATH \
    && cd /usr/java/latest/jre/lib/security \
    && sed -i 's%securerandom.source=file:/dev/urandom%securerandom.source=file:/dev/./urandom%g' java.security


EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh","run"]
