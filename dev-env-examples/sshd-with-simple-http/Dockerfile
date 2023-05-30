# 使用 Ubuntu 22.04 镜像作为基础镜像
FROM ubuntu:22.04

MAINTAINER "zzsuki"
LABEL description="A development environment based on ubuntu:jammy"
LABEL version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

# 更新软件包列表并安装所需软件包
RUN apt-get update && \
    apt-get install -y openssh-server python3 python3-pip git vim locales tzdata supervisor

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TZ=Asia/Shanghai

# 设置 root 用户密码为 'root'
RUN echo 'root:root' | chpasswd

# 配置 SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# 安装Flask
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple Flask
# 创建一个目录用于Flask服务
RUN mkdir -p /app
WORKDIR /app
COPY app.py /app/app.py
COPY supervisord.conf /etc/supervisor/supervisord.conf


# 设置 HTTP 服务器的端口为 80
EXPOSE 80

# 设置 SSH 服务器的端口为 22
EXPOSE 22

# 启动 SSH 服务和 Python HTTP 服务器
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]