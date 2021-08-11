# 构建ISO的教程文档

## 准备 
- 一个 `centos7` 的 ISO
- 一个能够创建虚拟机的机器

## 步骤

### Step1 安装Centos7-mini并且上传ISO到虚拟机，并挂载iso到本地 
```bash
mkdir -p /mnt/cdrom 
mount -o loop Centos7-.iso /mnt/cdrom 
/usr/bin/rsync -a --exclude=Packages/ --exclude=repodata/ /mnt/cdrom/ /ISO/
mkdir -p /ISO/{Packages,repodata}

```

###  Step2 安装依赖的程序到本地
> 增加的包; `gcc-8.3.1`, `kenel-5.4`, `docker-ce-20.10`
```bash

yum -y install epel-release centos-release-scl 
yum -y install fuse-devel devtoolset-8 

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum -y install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
yum -y --enablerepo=elrepo-kernel install kernel-lt

# 为了后面方便编译 pgsql 
yum -y install zlib-devel libxml2-devel
```

###  Step3 检验依赖包并拷贝到一个新的文件中。
> 如果在启动就拷贝，如果不在其中就后一步安装 
```bash

DVD='/mnt/cdrom/Packages'
#NEW_DVD='/ISO/Packages'
NEW_DVD='/opt/pkgs'

for x in $(cat t1.txt); 
do
  cp ${DVD}/$x.rpm ${NEW_DVD} || echo $x >> pkgs_add2.txt 
done 

yumdownloader --resolve --destdir /opt/pkgs  $(for x in `cat pkgs_add.txt`; do  printf $x' '; done)

```

### Step4 按照我们的需要更新 rpm 包 `comps.xml`
```bash

createrepo -g comps.yaml  .
```

### Step5 ISO打包工具
```bash

# TODO 只需要在需要同步的机器上安装即可。当然可以使用docker
yum -y install anaconda createrepo mkisofs rsync syslinux

genisoimage -joliet-long -V CentOS7 \
    -o CentOS79-20210730.iso -b isolinux/isolinux.bin -c isolinux/boot.cat \
    -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v \
    -cache-inodes -T -eltorito-alt-boot \
    -e images/efiboot.img -no-emul-boot /ISO
```

## 注意事项 
- 各个语言包一定要添加完成
- 一定要 sed -i 替换掉多余的字符, dos2unix 清理
- 一定要注意comps.xml里面的内容。
