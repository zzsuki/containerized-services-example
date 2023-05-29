# Trojan With Web Manager

## 说明

使用github开源项目[trojan](https://github.com/Jrohy/trojan)进行配置，由于项目镜像的问题，目前配置还比较麻烦，有空的时候会尝试优化下

## 使用

### 前置准备

**域名准备**

trojan使用的是基于tls的方式，所以一定要有证书，项目部署脚本提供了证书申请的功能，但需要有域名，而且**域名可解析到当前服务器的ip**

### 启动容器(默认已经安装了docker-compose和docker)

`docker-compose up -d`

### 进入trojan-web容器中进行配置操作(项目镜像不知道为何没有实现真正的服务运行，本质上还是要进行手动配置)

1. 进入容器: `docker exec -it trojan-web bash`
2. 安装trojan: `init`
3. 输入trojan进行安装: `trojan`，运行后按照提示一步一步进行操作即可，安装完成后，后台管理也使用这个命令

### 非必需

- 如果想更新管理程序，而不重建镜像: `source <(curl -sL https://git.io/trojan-install)`
