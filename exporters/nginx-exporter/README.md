# nginx监控

## nginx配置

为了监控nginx，需要nginx配置开启stub_status模块

1. 方法一：需要进入nginx服务端容器，开启stub_status;在`/etc/nginx/conf.d/`目录下新建文件`stub.conf`，并设置为以下内容：
```shell
    server { # simple load balancing
        listen          80;
        server_name     ${server-name};  # server name 为访问host，通过server name访问的会匹配到这个server

        location /nginx_status {
        stub_status ;
        allow all;    # 允许所有host访问
        }
    }
```
2. 方法二：使用预设的脚本进行添加： `bash check_stub.sh`

