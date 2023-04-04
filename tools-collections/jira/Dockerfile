FROM cptactionhank/atlassian-jira-software:latest

User root  

COPY ./atlassian-agent.jar /opt/atlassian/jira/atlassian-agent.jar

RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/jira/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/jira/bin/setenv.sh
