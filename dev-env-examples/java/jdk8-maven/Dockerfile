FROM ubuntu:jammy

LABEL maintainer="zzsuki <zzsuki-axfox@outlook.com>"
LABEL description="A simple java development environment based on ubuntu:jammy"
LABEL version="1.0"

ENV DEBIAN_FRONTEND=noninteractive 

# init apt source
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# install base tools
RUN apt-get update && apt-get install -y git vim locales tzdata
# setup file env 
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TZ=Asia/Shanghai
# install jdk8 and maven
RUN apt-get install -y openjdk-8-jdk maven
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
# fix locale
RUN locale-gen en_US.UTF-8
RUN bash -c 'echo -e "LANG=\"\"\nLANGUAGE=\"en_US.UTF-8:\"" >> /etc/default/locale'

EXPOSE 22/tcp
CMD ["tail", "-f", "/dev/null"]
