


```bash

docker run -itd \
    --name postgres \
    --restart always \
    -e POSTGRES_PASSWORD=test@1q2w2e4R \
     -e ALLOW_IP_RANGE=0.0.0.0/0 \
    -v /srv/docker/postgres/data:/var/lib/postgresql \
    -p 55433:5432  postgres:13 
```

## 2021/8/1

```bash

yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum install -y postgresql13-server

su - postgres <<- Code
psql <<- PSQLC
CREATE DATABASE topsec_pts;
CREATE USER superman CREATEDB LOGIN PASSWORD 'talent123';
GRANT ALL ON DATABASE topsec_pts TO superman;
PSQLC
Code

sudo -u git -H  <<-Code
ls ~
cat test
#other cmds
Code

sysbench  \
    --db-driver=pgsql  \
    --pgsql-host=127.0.0.1  \
    --pgsql-user=superman  \
    --pgsql-password=talent \
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


sysbench  \
    --db-driver=pgsql  \
    --pgsql-host=127.0.0.1  \
    --pgsql-user=superman  \
    --pgsql-password=talent \
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


# cleanup 是清理

```
