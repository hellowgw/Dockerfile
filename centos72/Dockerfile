FROM scratch
MAINTAINER hellowgw CentOS 7
ADD centos-7.2.1511-docker.tar.xz /
LABEL name="CentOS 7.2" \
    build-date="2017-07-17"

RUN yum install -y gcc gcc-c++ automake autoconf libtool make gcc-c openssl-devel net-tools\
    && groupadd -g 501 www \
    && useradd -u 501 -g www -s /sbin/nologin www \
    && mkdir -p /data/{application,src,logs}

CMD ["/bin/bash"]
