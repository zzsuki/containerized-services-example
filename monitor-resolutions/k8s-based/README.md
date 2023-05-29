# 基于Consul的Prometheus监控环境

## 监控环境部署

首先需要有一个k8s集群，然后先部署consul，再部署prometheus，最后grafana

没有namespace的话先创建一个namespace：`kubectl create namespace monitor`

一般先部署`service account`，然后部署`config map`，接着部署`deployment/stateful set`，最后部署service为服务暴露端口

**部署时推荐使用apply部署，配置文件更新后，可以使用replace方式更新（但该方式只支持配置文件变更的情况，如果是对应config map发生了改变，那么replace不会替换deployment）**

## 服务注册 && 注销

环境支持服务发现，可以通过consul的服务接口完成服务注册。example:

``` shell
curl -X PUT -d '{
  "ID": "node-exporter-10-30-6-68",
  "Name": "node-exporter-10-30-6-68",
  "Tags": [
    "node"
  ],
  "Address": "10.30.6.68",
  "Port": 9100,
  "Meta": {
    "vm": "false",
    "app": "node",
    "person": "zzsuki",
    "project": "default"
  },
  "EnableTagOverride": false,
  "Check": {
    "HTTP": "http://10.30.6.68:9100/metrics",
    "Interval": "10s"
  }
}' http://10.30.2.254:30081/v1/agent/service/register/
```

**注销**：需要注销时，只需要吧url的register改成deregister即可

## Tips

1. 善用prometheus relabel机制可以定义适合自己的标签
2. consul client定位是纯计算，一般不成在数据中心的功能；所以推荐要有server
3. consul 集群如果recreate了server，client也推荐进行recreate，因为服务中的ip地址不会自动更新（可以通过svc配置解决，后续研究下）
4. 好用的grafana看板：
    - node-exporter: 8919、1860、11074
    - redis-exporter: 14091、11835
    - clickhouse-exporter: 13606
    - postgres-exporter: 10521（性能看板，latency类的数据稍微多点）、445
    - kafka-exporter: 7589
    - nginx-exporter: 12708
    - minio-exporter