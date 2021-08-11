#!/bin/bash
# 20210722 generate add fio/netmask/mem
# 20210711 create by xx_zhang
# shellcheck disable=SC1073

RESULT_ROOT=/topsec-pts/
RESULT_PATH=${RESULT_ROOT}/$(date +%Y%m%d%H)

if [ -z $1 ]; then
   TEST_DIR=$(cd $(dirname $0); pwd)
else
   TEST_DIR=$1
fi

# shellcheck disable=SC1046
if [ ! -d ${TEST_DIR} ]; then
  mkdir -p ${TEST_DIR};
  mkdir -p ${TEST_DIR}/cpu/  ${TEST_DIR}/mem/ ${TEST_DIR}/disk/  \
    ${TEST_DIR}/net/
fi

# TODO 记录基本的主机信息
export TEST_SYSTEM_INFO_CPU=${RESULT_PATH}/info/cpu
export TEST_SYSTEM_INFO_MEM=${RESULT_PATH}/info/memory
export TEST_SYSTEM_INFO_DISK=${RESULT_PATH}/info/disk
export TEST_SYSTEM_INFO_ETHER=${RESULT_PATH}/info/ether
export TEST_SYSTEM_INFO_NET=${RESULT_PATH}/info/ethr

# TODO 记录CPU性能
export TEST_CPU_SYSBENCH=${RESULT_PATH}/cpu/sysbench_cpu
export TEST_CPU_UNIXBENCH=${RESULT_PATH}/cpu/unixbench_cpu

# TODO 记录内存性能
export TEST_MEM_SYSBENCH=${RESULT_PATH}/cpu/sysbench_cpu

# TODO 记录磁盘性能
export TEST_DISK_DD_FDS1=${RESULT_PATH}/disk/dd__fdatasync1
export TEST_DISK_DD_FDS12${RESULT_PATH}/disk/dd__fdatasync2
export TEST_DISK_DD_DS1=${RSULT_PATH}/disk/dd__dsync1
export TEST_DISK_DD_DS2=${RESULT_PATH}/disk/dd__dsync2
export TEST_DISK_IOP_RD=${RESULT_PATH}/disk/ioping_seek_rate
export TEST_DISK_IOP_RL=${RESULT_PATH}/disk/ioping_sequence
export TEST_DISK_IOP_RC=${RESULT_PATH}/disk/ioping_cache
export TEST_DISK_FIO_FW=${RESULT_PATH}/disk/fio_disk__full_write
export TEST_DISK_FIO_RD=${RESULT_PATH}/disk/fio_disk__random_read
export TEST_DISK_FIO_RW=${RESULT_PATH}/disk/fio_disk__random_write

##  TODO 记录网络性能
export TEST_ETHER_SP_=${RESULT_PATH}/ether/sockperf_pp
export TEST_ETHER_SP_=${RESULT_PATH}/ether/sockperf_
export TEST_DISK_DD_DS1=${RSULT_PATH}/ether/sockperf_

## TODO 记录 pgsql 性能
export TEST_MEM_SYSBENCH=${RESULT_PATH}/pgsql/sysbench_pgsql

## TODO 记录 elasticserach 性能
export TEST_ES_RALLY=${RESULT_PATH}/es/rally



MY_CPU_COUNT=$(grep -c processor /proc/cpuinfo)

function check_deps
{
  echo 'EVERYTHING IS OK'
}

function sys_info
{
  echo

}

function cpu_sysbench
{

}

function mem_sysbench
{

}

function ioping_disk
{


}

function fio_disk__random_red
{


}

function fio_disk__random_red
{

}

function cpu_unixbench
{


}



case "$1" in
"start")
  start
  ;;
"restart")
  restart
  ;;
"stop")
  stop
  ;;
"version")
  version
  ;;
"status")
  status
  ;;
"waf")
  waf
  ;;
*)
  echo "usage:(start|stop|restart|status|version|waf)"
  exit
  ;;
esac
