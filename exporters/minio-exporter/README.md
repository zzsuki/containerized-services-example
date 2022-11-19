# 使用自带mc生成可直接用于prometheus的监控配置

## 下载mc（minio客户端）

1. wget https://dl.min.io/client/mc/release/linux-amd64/mc
2. chmod +x mc

## 设置alias并生成prometheus配置
1. `./mc alias list`
    
    查看当前alias

2. `./mc alias set demo http://${minio}:9000`

    设置alias，中间会要求输入key和secret，对应一般为minio的admin用户的鉴权方式
3. `./mc admin prometheus generate demo`

    生成prometheus配置，生成后复制到prometheus的scrape_configs中，重启服务即可，以下为一段生成的示例：

    ```yaml
    - job_name: minio-job
        bearer_token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ4MTA1MjM4ODUsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJyYW5nZSJ9.wH_DvN2NF6NK4bq_QzbD4J3yTSYCIPyNr8k-2KJcCQC5unsYowsh0Ks2e4nmVjyE-5-nNMSpNm8m1wL2gbjqUQ
        metrics_path: /minio/v2/metrics/cluster
        scheme: http
        static_configs:
            - targets: ['localhost:9000']
    ```

4. 配置验证可通过curl命令查看
    - `curl -v -sSL -H 'Authorization: Bearer 上面申请的token' http://${minio}:9000/minio/v2/metrics/cluster`

## minio监控内容

使用的dashboard：13502