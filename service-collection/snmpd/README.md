# SNMPD

## 描述

## 部署

## 测试

部署完成后使用`snmpwalk -v 2c -c public localhost 1.3.6.1.2.1.1.1.0`可以检查是否正常运行。（该OID是一个常见的返回系统描述的oid,一般情况下linux系统都有，所以很适合拿来测试）,正常返回应该类似：

```bash
root@devstack:~/snmpd# snmpwalk -v 2c -c public localhost 1.3.6.1.2.1.1.1.0
iso.3.6.1.2.1.1.1.0 = STRING: "Linux cb696cb4fc4c 5.15.0-69-generic #76-Ubuntu SMP Fri Mar 17 17:19:29 UTC 2023 x86_64"
```