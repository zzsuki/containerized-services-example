# Jira 8

## Description

Jira is a proprietary issue tracking product, developed by Atlassian. It provides bug tracking, issue tracking, and project management functions. This project is only used for testing purposes.

## Usage

### Setup Jira

1. start service: `docker-compose.yml up -d`
2. open browser: `http://localhost:8081`
3. setup Jira by following the wizard(stop at license registration)
4. generate license
    1. enter `jira` container: `docker exec -it jira /bin/bash`
    2. use `atlassian-agent.jar` to generate license: `java -jar atlassian-agent.jar -p jira -m <admin_email> -n zzsuki -o <base_url> -s <server_id(id in wizard)>`
5. copy license to wizard


### Setup Third Part Jira Plugin

same as jira setup, need to get plugin info in jira marketplace
