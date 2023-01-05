# 监控方案与配置集合

本项目主要用于收集和整合各种可用的监控配置信息，以便于快速搭建一个可用的监控系统。其中包含部分之前学习的内容

## 项目目录

- exporters: 收集各种监控工具的配置信息
- k8s-cluster-monitor: 收集各种k8s集群监控的配置信息
- log-inspect: 收集各种日志监控工具和配置信息，目前基于efk实现
- service-monitor: 收集各种服务监控的配置信息，目前基于prometheus grafana alertmanager，服务发现使用consul
  - docker-based: 基于docker的监控配置
  - k8s-based: 基于k8s的监控配置
- service-collection: 收集各种常用服务的部署配置，可以用于构造测试环境

## 支持的范围

- prometheus + grafana + alert manager + consul 服务监控告警
- es + fluentd + kibana日志监控分析
- kube-state-metrics：k8s集群的监控app，可以提供集群数据
- 部分服务的docker-compose文件
  - clickhouse
  - ftp
  - http
  - nginx
  - postgresql
  - radius
  - snmptrapd
  - syslog-ng

## To be continued

- [ ] docker中的consul支持
- [ ] 更多的服务支持
