#!/bin/bash

# check root privilege
if [ $EUID != 0 ]; then
    echo "This script must be run as root, use sudo $0 instead" 1>&2
    exit 1
fi

# enable debug info
set -x

# check OS type
check_os(){
    os=`cat /etc/os-release | grep -w "ID" | cut -d '=' -f 2`
    if [ $os == "ubuntu" ]; then
        echo "ubuntu"
    elif [ $os == "centos" ]; then
        echo "centos"
    else
        echo "not support os"
        exit 1
    fi
}

# dependencies on ubuntu
build_ubuntu_dependencies(){
    apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
}

# dependencies on centos
build_centos_dependencies(){
    yum install -y yum-utils device-mapper-persistent-data lvm2
}


build_centos_docker(){
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
    yum makecache fast
    yum install docker-ce
    systemctl enable docker
    # add current user to docker group
    current_user=`whoami`
    usermod -aG docker $current_user
}


build_ubuntu_docker(){
    # ubuntu20 may not have keyrings dir
    if [ ! -d "/etc/apt/keyrings" ]; then
        mkdir -p "/etc/apt/keyrings"
    fi
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    apt install docker-ce
    systemctl enable docker
    # add current user to docker group
    current_user=`whoami`
    usermod -aG docker $current_user
}


change_docker_source(){
    # change docker source to ustc
    cat > /etc/docker/daemon.json << EOF
{
    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m"
    },
    "storage-driver": "overlay2"
}
EOF
    systemctl restart docker
}


install_compose(){
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}


install_docker(){
    os=`check_os`
    # install docker
    docker -v
    if [ $? != 0 ]; then
        echo "docker not installed, install docker...."
        if [ $os == "ubuntu" ]; then
            build_ubuntu_dependencies
            build_ubuntu_docker
        elif [ $os == "centos" ]; then
            build_centos_dependencies
            build_centos_docker
        else
            echo "not support os"
            exit 1
        fi
    else
        echo "docker already installed, skipping..."
    fi
    change_docker_source
    # install docker-compose
    docker-compose -v
    if [ $? != 0 ]; then
        echo "docker-compose not installed, install docker-compose"
        install_compose
    else
        echo "docker-compose already installed, skipping..."
    fi
}

# 安装docker
install_docker
# 提示重启服务器
echo -e "\033[34m Reboot is recommended to make current user a docker user !!! \033[0m”"