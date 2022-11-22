#!/bin/bash

set -e

if [ $EUID != 0 ]; then
    echo "This script must be run as root, use sudo $0 instead" 1>&2
    exit 1
fi

# 部分包不是docker的依赖，只是个人习惯都装好
apt update && apt install -y git build-essential zlib1g-dev libpcap-dev gcc libnuma-dev numactl ca-certificates

install_dependencies(){
    apt install -y ca-certificates
}

install_docker(){
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install docker-ce -y
    # 将当前用户加入docker组
    current_user=`whoami`
    usermod -aG docker $current_user
}

install_docker_compose(){
    curl -L https://get.daocloud.io/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

# 安装依赖
install_dependencies

# 安装docker
docker -v
if [ $? != 0 ]; then
    echo "docker not installed, install docker...."
    install_docker
    systemctl is-active docker
    if [ $? != 0 ]; then
        systemctl restart docker
    fi
fi
# 安装docker-compose
docker-compose -v
if [ $? != 0 ]; then
    echo "docker-compose not installed, install docker-compose"
    install_docker_compose
fi