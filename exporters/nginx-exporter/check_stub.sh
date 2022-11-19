#!/bin/sh

# shellcheck disable=SC2039
if [ $EUID != 0 ]; then
    echo "需要root权限运行, 使用 sudo $0 " 1>&2
    exit 1
fi

set -e

container="nginx"    # nginx所在容器名称

enable_stub(){
  # shellcheck disable=SC2154
  cat <<< "
  server { # simple load balancing
    listen          80;
    server_name     nginx;  # server name 为访问host，通过server name访问的会匹配到这个server

    location /nginx_status {
      stub_status ;
      allow all;    # 允许所有host访问
    }
  }
  " > /tmp/stub.conf

  docker cp /tmp/stub.conf "$container:/etc/nginx/conf.d/"
  docker exec "$container" sh -c "nginx -s reload"
}


status=$(docker exec $container sh -c "test -f /etc/nginx/conf.d/stub.conf && echo yes || echo no")

if [ "$status" = 'no' ]
then
  enable_stub
  echo 'stub.conf not found, enable stub...'
else
  echo 'stub.conf exists, skip...'
fi