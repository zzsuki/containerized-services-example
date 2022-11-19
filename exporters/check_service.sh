#!/bin/sh

# shellcheck disable=SC2039
if [ $EUID != 0 ]; then
  echo "需要root权限运行, 使用 sudo $0 " 1>&2
  exit 1
fi

if [ $# != 1 ]; then
  echo "Parameter not specified.."
  echo "Usage: $0 [host]; eg: $0 192.168.0.10"
  exit 1
fi

set -e

host=$1


check_service(){
  # shellcheck disable=SC2154
  curl -s http://"$host":9121/metrics > /dev/null && echo "redis-exporter ready." || echo "redis-exporter not ready."
  curl -s http://"$host":9540/metrics > /dev/null && echo "celery-exporter ready." || echo "celery-exporter not ready."
  curl -s http://"$host":9180/metrics > /dev/null && echo "openstack-exporter ready." || echo "openstack-exporter not ready."
  curl -s http://"$host":9290/metrics > /dev/null && echo "minio-exporter ready." || echo "minio-exporter not ready."
  curl -s http://"$host":9113/metrics > /dev/null && echo "nginx-exporter ready." || echo "nginx-exporter not ready."
  curl -s http://"$host":9187/metrics > /dev/null && echo "postgres-exporter ready." || echo "postgres-exporter not ready."
  curl -s http://"$host":8080/metrics > /dev/null && echo "cadvisor ready." || echo "cadvisor not ready."
  curl -s http://"$host":9100/metrics > /dev/null && echo "node-exporter ready." || echo "node-exporter not ready."
}

check_service
