# Oracle 11 Database

## Introduction

This environment is based on project [oracle-xe-11g](https://hub.docker.com/r/wnameless/oracle-xe-11g-r2).

## Usage

```bash
docker-compose up -d
```

## Default Configuration

- hostname: localhost
- port: 1521
- sid: xe
- username: system
- password: oracle

## Login Database

```bash
docker exec -it oracle bash
# 进入容器后，使用sqlplus登录数据库，输入相应的鉴权信息
sqlplus
```