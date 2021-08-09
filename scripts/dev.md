# 开发脚本内容 

## 准备的工具
```bash
net-tools tranceroute  nmap-ncat
iperf3 
ioping 
fio 
sysbench 
ethr
sockperf

```
- [ethr](https://github.com/microsoft/ethr)
- [性能测试-golang](https://github.com/Allenxuxu/gev/blob/master/README-ZH.md)

## dd/ioping/fio 


```shell script

# DD
echo_step "dd 1Mx1k fdatasync"
echo_code start
MY_DD=$(dd if="/dev/zero" of="$MY_DIR/io-test" bs=1M count=1k conv=fdatasync 2>&1)
echo "$MY_DD" >> "$MY_OUTPUT"
echo_code end

echo_step "dd 64kx16k fdatasync"
echo_code start
MY_DD=$(dd if="/dev/zero" of="$MY_DIR/io-test" bs=64k count=16k conv=fdatasync 2>&1)
echo "$MY_DD" >> "$MY_OUTPUT"
echo_code end

echo_step "dd 1Mx1k dsync"
echo_code start
MY_DD=$(dd if="/dev/zero" of="$MY_DIR/io-test" bs=1M count=1k oflag=dsync 2>&1)
echo "$MY_DD" >> "$MY_OUTPUT"
echo_code end

echo_step "dd 64kx16k dsync"
echo_code start
MY_DD=$(dd if="/dev/zero" of="$MY_DIR/io-test" bs=64k count=16k oflag=dsync 2>&1)
echo "$MY_DD" >> "$MY_OUTPUT"
echo_code end

# IOPing
echo_step "IOPing"
echo_code start
ioping -c 10 "$MY_DIR/" >> "$MY_OUTPUT"
echo_code end

echo_step "IOPing seek rate"
echo_code start
ioping -RD "$MY_DIR/" >> "$MY_OUTPUT"
echo_code end

echo_step "IOPing sequential"
echo_code start
ioping -RL "$MY_DIR/" >> "$MY_OUTPUT"
echo_code end

echo_step "IOPing cached"
echo_code start
ioping -RC "$MY_DIR/" >> "$MY_OUTPUT"
echo_code end

# FIO
echo_step "FIO full write pass"
echo_code start
fio --name=writefile --size=10G --filesize=10G \
	--filename="$MY_DIR/io-test" \
	--bs=1M --nrfiles=1 \
	--direct=1 --sync=0 --randrepeat=0 --rw=write --refill_buffers --end_fsync=1 \
	--iodepth=200 --ioengine=libaio >> "$MY_OUTPUT"
echo_code end

echo_step "FIO rand read"
echo_code start
fio --time_based --name=benchmark --size=10G --runtime=30 \
	--filename="$MY_DIR/io-test" \
	--ioengine=libaio --randrepeat=0 \
	--iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
	--numjobs=4 --rw=randread --blocksize=4k --group_reporting >> "$MY_OUTPUT"
echo_code end

echo_step "FIO rand write"
echo_code start
fio --time_based --name=benchmark --size=10G --runtime=30 \
	--filename="$MY_DIR/io-test" \
	--ioengine=libaio --randrepeat=0 \
	--iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
	--numjobs=4 --rw=randwrite --blocksize=4k --group_reporting >> "$MY_OUTPUT"

echo_code end


#####################################################################
# Run SysBench
#####################################################################

echo_title "SysBench"

echo_step "SysBench Single-Core CPU performance test (1 thread)"
echo_code start
sysbench cpu --cpu-max-prime=20000 --threads=1 run >> "$MY_OUTPUT"
echo_code end

if [[ $MY_CPU_COUNT -gt "0" ]]; then
	echo_step "SysBench Multi-Core CPU performance test ($MY_CPU_COUNT threads)"
	echo_code start
	sysbench cpu --cpu-max-prime=20000 --threads="$MY_CPU_COUNT" run >> "$MY_OUTPUT"
	echo_code end
fi

echo_step "SysBench Memory functions speed test"
echo_code start
sysbench memory run >> "$MY_OUTPUT"
echo_code end

#####################################################################
# Run UnixBench
#####################################################################

echo_line
echo " Now let's run the good old UnixBench. This takes a while."
echo_line
echo_title "UnixBench"
echo_code start
perl "$MY_DIR/UnixBench/Run" -c "1" -c "$MY_CPU_COUNT" >> "$MY_OUTPUT" 2>&1
echo_code end

```

## sockperf 测试
```bash 
sockperf server & 

sockper ping-pong 
sockper throughput
sockper under-load 

```