#!/bin/bash

wget -t 3 -T 15 https://sms-agent-2-0-cn-north-1.obs.cn-north-1.myhuaweicloud.com/SMS-Agent.tar.gz 

# 将本内容在linux机器中生成一个.sh文件, 在SMS-Agent.tar.gz安装包目录bash执行该sh文件即可
# ak sk sms域名替换成真正的，{}不保留

AK=""
SK=""
DOMAIN="sms.cn-north-4.myhuaweicloud.com"

tar -zxvf SMS-Agent.tar.gz
cd SMS-Agent/agent

log_dir="Logs"
log_file="Logs/startup.log"
check_log_file="Logs/check.log" 

if [ -e "$log_file" ]; then
    cat /dev/null > ${log_file}
    cat /dev/null > ${check_log_file}
    else
    mkdir -p $log_dir
    touch -f $log_file
    touch -f ${check_log_file}
fi

if [ ! -e "linuxmain" ]; then cp -f "x64/linuxmain" . ; fi 

./linuxmain pre-check > /dev/null 2>&1
echo $AK $SK $DOMAIN | ./linuxmain  > /dev/null 2>&1 &


