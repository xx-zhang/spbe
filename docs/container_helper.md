# postgresql 服务端环境搭建和初始化。

## 安装部分 【这部分iso已经做了，可以跳过】

### 使用 Docker 安装 pgsql-13
```bash
docker run -itd \
    --name postgres \
    --restart always \
    -e POSTGRES_PASSWORD=test@1q2w2e4R \
     -e ALLOW_IP_RANGE=0.0.0.0/0 \
    -v /srv/docker/postgres/data:/var/lib/postgresql \
    -p 55433:5432  postgres:13 
```

### 宿主机安装 pgsql-13
```bash

yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum install -y postgresql13-server
```


## 初始化数据库
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

## 使用sysbench 初始化pgsql测试表格。
```bash

sysbench  \
    --db-driver=pgsql  \
    --pgsql-host=127.0.0.1  \
    --pgsql-user=superman  \
    --pgsql-password=talent123 \
    --pgsql-db=topsec_pts  \
    --oltp-table-size=10000  \
    --rand-init=on  \
    --threads=10 \
    --time=120  \
    --events=0 \
    --report-interval=10  \
    --percentile=99  \
    /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  \
    prepare

```

## sysbench 开始测试 pgsql
```bash 
sysbench  \
    --db-driver=pgsql  \
    --pgsql-host=127.0.0.1  \
    --pgsql-user=superman  \
    --pgsql-password=talent123 \
    --pgsql-db=topsec_pts  \
    --oltp-table-size=10000  \
    --rand-init=on  \
    --threads=10 \
    --time=120  \
    --events=0 \
    --report-interval=10  \
    --percentile=99  \
    /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  \
    run 
```

# cleanup 是清理

```
