#!/bin/bash
#
# Copyright © 2019 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: Osmosis Sync Monitor.
# User: Robin@ExinPool
# Date: 2022-10-24
# Time: 11:26:18

# load the config library functions
source config.shlib

# load configuration
service="$(config_get SERVICE)"
local_host="$(config_get LOCAL_HOST)"
remote_host_first="$(config_get REMOTE_HOST_FIRST)"
remote_host_second="$(config_get REMOTE_HOST_SECOND)"
abs_num="$(config_get ABS_NUM)"
node_id="$(config_get NODE_ID)"
log_file="$(config_get LOG_FILE)"
lark_webhook_url="$(config_get LARK_WEBHOOK_URL)"

local_blocks=`curl --silent --request GET --url ${local_host} --header 'Content-Type: application/json' | jq | grep latest_block_height | awk -F':' '{print $2}' | sed 's/"//g' | sed "s/,//g" | sed "s/\ //g"`
remote_first_blocks=`curl --silent --request GET --url ${remote_host_first} --header 'Content-Type: application/json' | jq | grep latest_block_height | awk -F':' '{print $2}' | sed 's/"//g' | sed "s/,//g" | sed "s/\ //g"`
remote_second_blocks=`curl --silent --request GET --url ${remote_host_second} --header 'Content-Type: application/json' | jq | grep latest_block_height | awk -F':' '{print $2}' | sed 's/"//g' | sed "s/,//g" | sed "s/\ //g"`
log="`date '+%Y-%m-%d %H:%M:%S'` UTC `hostname` `whoami` INFO local_blocks: ${local_blocks}, remote_first_blocks: ${remote_first_blocks}, remote_second_blocks: ${remote_second_blocks}"
echo $log >> $log_file

local_first=$((local_blocks - remote_first_blocks))
local_second=$((local_blocks - remote_second_blocks))

if [ ${remote_first_blocks} -eq 0 ] || [ ${remote_second_blocks} -eq 0 ]
then
    log="时间: `date '+%Y-%m-%d %H:%M:%S'` UTC \n主机名: `hostname` \n节点: ${local_host}, ${local_blocks} \n远端节点 1: ${remote_host_first}, ${remote_first_blocks} \n远端节点 2: ${remote_host_second}, ${remote_second_blocks} \n状态: 远端节点区块为 0，停止检测。"
    echo -e $log >> $log_file
    exit 1
fi

if [ ${local_first#-} -gt ${abs_num} ] && [ ${local_second#-} -gt ${abs_num} ]
then
    log="时间: `date '+%Y-%m-%d %H:%M:%S'` UTC \n主机名: `hostname` \n节点: ${local_host}, ${local_blocks} \n远端节点 1: ${remote_host_first}, ${remote_first_blocks} \n远端节点 2: ${remote_host_second}, ${remote_second_blocks} \n状态: 区块数据不同步。"
    echo -e $log >> $log_file
    curl -X POST -H "Content-Type: application/json" -d '{"msg_type":"text","content":{"text":"'"$log"'"}}' ${lark_webhook_url}
else
    log="`date '+%Y-%m-%d %H:%M:%S'` UTC `hostname` `whoami` INFO ${service} ${local_host} status is normal."
    echo $log >> $log_file
fi
