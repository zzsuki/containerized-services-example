FROM ubuntu:latest
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y snmpd snmp snmp-mibs-downloader
COPY snmpd.conf /etc/snmp/
EXPOSE 161/udp
CMD ["snmpd", "-f"]
