#!/usr/bin/python3
import os
import subprocess
import time
from datetime import datetime
import configparser
# import logging
import asyncio

BASE_DIR = os.path.dirname(__file__)
DEFAULT_CFG = os.path.join(BASE_DIR, 'systest.ini')


def exec_shell(cmd, sleep_long=1):
    sub2 = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    try:
        time.sleep(sleep_long)
        os.waitpid(sub2.pid, os.W_OK)
    except:
        pass
    stdout, stderr = sub2.communicate()
    ret = sub2.returncode
    if ret == 0:
        try:
            return ret, stdout.decode('utf-8').split('\n')
        except:
            return ret, stdout.decode('gb2312').split('\n')
    raise Exception('{} RUN ERROR'.format(cmd))


class ExecInfo:

    def __init__(self, name, desc, cmd, args=None, result_path='/temp'):
        """
        执行任务的初始化函数
        :param name: 执行shell的名称
        :param desc: 执行命令的描述
        :param cmd:   执行的命令
        :param args:  执行的命的参数
        :param result_path: 结果存储路径
        """
        self.name = name
        self.cmd = cmd
        self.desc = desc
        self.args = args
        self.result_path = result_path

    async def exec(self):
        __desc = f'执行-{self.name} {self.desc} - {datetime.now()}'
        print(__desc)
        start_time = datetime.now()
        await exec_shell(self.cmd + f">> \"{self.result_path}\" 2>&1")
        end_time = datetime.now()
        spend = end_time - start_time
        print(f'--{self.desc}--花费--{spend}--')


class ConfigManger:

    def __init__(self, cfg_path=DEFAULT_CFG):
        self.cfg_path = cfg_path
        config = configparser.ConfigParser()
        config.read(cfg_path, encoding="utf-8")
        self.cfg = config

    def get_configs(self):
        __cfg = self.cfg
        for x in __cfg.sections():
            data = __cfg[x]
            print(data.items())


def main():
    loop = asyncio.get_event_loop()
    tasks = []
    for x in range(1111):
        tasks.append(asyncio.ensure_future(x))
    loop.run_until_complete(asyncio.wait(tasks))


if __name__ == '__main__':
    ConfigManger().get_configs()
