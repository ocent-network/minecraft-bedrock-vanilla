#!/bin/bash
sleep 3

cd /home/container

export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Ensure binary is executable
chmod +x /home/container/bedrock_server

${MODIFIED_STARTUP}