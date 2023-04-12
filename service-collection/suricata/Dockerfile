FROM ubuntu:jammy

LABEL maintainer="zzsuki <zzsuki@163.com>"
LABEL description="A simple surciata development environment based on ubuntu:jammy"
LABEL version="1.0"

USER root
WORKDIR /mnt

ENV DEBIAN_FRONTEND=noninteractive 

# init apt source
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# install base tools
RUN apt-get update && apt-get install -y git vim locales tzdata
# setup file env 
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TZ=Asia/Shanghai
# install dependencies
RUN apt install -y rustc cargo libpcre3 libpcre3-dbg libpcre3-dev liblua5.1-0-dev libhiredis-dev\
    build-essential autoconf automake libtool libpcap-dev libnet1-dev libgeoip-dev libevent-dev\
    libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 libnss3-dev gcc\
    make libmagic-dev libjansson-dev libjansson4 pkg-config suricata-update python3 python3-pip

ADD http://49.234.13.201/suricata/suricata-6.0.9.tar.gz /tmp/suricata-6.0.tar.gz
RUN mkdir -p /tmp/suricata && tar -xvf /tmp/suricata-6.0.tar.gz -C /tmp/suricata --strip-components 1
RUN cd /tmp/suricata && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && make && make install
RUN ldconfig
RUN mkdir -p /var/log/suricata  && mkdir -p /etc/suricata/rules

COPY ./etc/suricata/* /etc/suricata/

# fix locale

CMD ["suricata", "-c", "/etc/suricata/suricata.yaml", "--af-packet"]
