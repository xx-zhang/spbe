
#!/bin/bash
%post

mkdir -p /mnt/sysimage/xfs/
cp  -r /run/install/repo/xfs/* /mnt/sysimage/xfs/
# sudo chmod -R 755 /ISO/topsec/

# update env
cp /run/install/repo/xfs/xfs.env /mnt/sysimage/etc/
echo "[OK] Update files to system fs."

%end

%post --log=/root/ks-post-soft.log
#!/bin/bash

echo "Install softwares for pts."
# python-3.8.11
chmod u+x /xfs/python3.8.11-cp38-cp38-manylinux1_x86_64.AppImage
cd /xfs && /xfs/python3.8.11-cp38-cp38-manylinux1_x86_64.AppImage --appimage-extract
mv /xfs/squashfs-root /usr/local/python3
ln -sf /usr/local/python3//usr/bin/python3 /usr/bin/python3
ln -sf /usr/local/python3/usr/bin/pip3 /usr/bin/pip3
rm -rf /xfs/python3.8.11-cp38-cp38-manylinux1_x86_64.AppImage

# openjdk-16
tar xf /xfs/openjdk-16.0.2_linux-x64_bin.tar.gz -C /usr/local/
ln -sf /usr/local/jdk-16.0.2/bin/java /usr/bin/java
rm -rf /xfs/openjdk-16.0.2_linux-x64_bin.tar.gz

# git-2.28.1
chmod u+x /xfs/git-x86_64.AppImage
cd /xfs && /xfs/git-x86_64.AppImage --appimage-extract
mv /xfs/squashfs-root /usr/local/git
ln -sf /usr/local/git/bin/git /usr/bin/git
rm -rf /xfs/git-x86_64.AppImage

# postgres -13
# pgsql ->  https://zhuanlan.zhihu.com/p/266853489
/usr/pgsql-13/bin/postgresql-13-setup initdb
/usr/bin/systemctl restart postgresql-13.service
#/usr/bin/chown -R postgres:postgres /var/lib/pgsql/13/data/
su - postgres <<- Code
psql <<- PSQLC
CREATE DATABASE topsec_pts;
CREATE USER superman CREATEDB LOGIN PASSWORD 'talent123';
GRANT ALL ON DATABASE topsec_pts TO superman;
PSQLC
Code

# start es-6.8.5
cd /xfs && unzip elasticsearch-6.8.18.zip -d /usr/local/
/usr/sbin/groupadd es
/usr/sbin/useradd es -g es -p es
/usr/bin/chown -R es:es /usr/local/elasticsearch-6.8.18/
/usr/bin/su - es <<- Code
/usr/local/elasticsearch-6.8.18/bin/elasticsearch -d
Code

# start docker-ce
/usr/bin/systemctl enable docker
/usr/bin/systemctl restart docker

# add unixbench-5.1.3
cd /xfs && tar xf /xfs/byte-unixbench-5.1.3.tar.gz -C /usr/local/
cd /usr/local/byte-unixbench-5.1.3/UnixBench/ && make -j2 && ln -sf /usr/local/byte-unixbench-5.1.3/UnixBench/Run /usr/bin/unixbench

## add geekbench5
echo 'geekbench current not support, you should download it and run yourself.'

# add ethr to bin
cp /xfs/ethr /usr/bin/

# active source profile
echo 'we can't active the profile'
#source /etc/profile

echo 'Ending inital soft.'
