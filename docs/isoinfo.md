# ISO 内容说明 (基于 Cenos7.9.2003 修改)

- ISO 自动安装, 无交互，只有一个选项，自动安装到磁盘。
- 时区默认上海, lang en.UFT-8
- rpm 包含了 `sysbench`, `ioping`, `fio`, `sockperf`, `ethr`
- ISO 修改 `gcc`  4.8  -> 8.3.1 
- 自带 `openjdk-16`
- 更新了默认内核 `linux-kenel` 3.10 -> 5.4 并保留了原内核。
- 自带 `postgresql-13`
- 自带 `docker-ce 20.10` 
- 自带 `elasticsearch - 6.8.18`
- 挂载了 `/xfs` 目录，会有部分工具或者用到的安装包

***NOTE: 按需启动。**

## 启动docker
```bash
systemctl start docker 
# 开机自启动 
system enable docker 
```

## 启动和初始化pgsql
```bash
# 启动pgsql-13并且初始化数据库、以及创建默认的数据库测试用户
/usr/pgsql-13/bin/postgresql-13-setup initdb
/usr/bin/systemctl restart postgresql-13.service

su - postgres <<- Code
psql <<- PSQLC
CREATE DATABASE topsec_pts;
CREATE USER superman CREATEDB LOGIN PASSWORD 'talent123';
GRANT ALL ON DATABASE topsec_pts TO superman;
PSQLC
Code

```

## 启动ES
```bash

/usr/bin/su - es <<- Code
/usr/local/elasticsearch-6.8.18/bin/elasticsearch -d
Code
```


