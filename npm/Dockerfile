FROM debian:latest
MAINTAINER wanggw
  
# SET ENVIRONMENT
ENV NODE=node-v11.9.0-linux-x64 \
SRC_PATH=/usr/local/src \
DOWNLOAD_SERVER=http://172.16.1.254/soft

# SET TIMEZONE
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo 'Asia/Shanghai' >/etc/timezone

ADD node-v11.9.0-linux-x64.tar.gz /usr/local/

# INSTALL CNPM
#RUN apt-get install -y wget \
#&& wget -O $SRC_PATH/${NODE}.tar.gz $DOWNLOAD_SERVER/${NODE}.tar.gz \
#&& cd $SRC_PATH \
#&& tar zxf ${NODE}.tar.gz -C /usr/local/ \
RUN ln -s /usr/local/${NODE}/bin/npm /usr/local/bin/npm \ 
&& ln -s /usr/local/${NODE}/bin/node /usr/local/bin/node \
&& /usr/local/${NODE}/bin/npm install -g cnpm --registry=https://registry.npm.taobao.org \
&& ln -s /usr/local/${NODE}/bin/cnpm /usr/local/bin/cnpm 

CMD ["/bin/bash"]


