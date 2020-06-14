#!/bin/bash
#@author Filip Oščádal <oscadal@gscloud.cz>

cd "$(dirname "$0")"
export PATH=$PATH:/snap/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=$PATH:$HOME/go/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/scripts

sudo iptables -t nat -L -n | grep 6377
sudo iptables -t nat -L -n | grep 6378

function rcli1 {
  sudo docker exec -it redisearch redis-cli $1
}

function rcli2 {
  sudo docker exec -it redis redis-cli $1
}

echo -ne "\n\n\e[32mRediSearch\e[0m\n"
rcli1 info | grep redis
echo -ne "\n"
rcli1 info | grep keys

echo -ne "\n\n\e[32mRedis\e[0m\n"
rcli2 info | grep redis
echo -ne "\n"
rcli2 info | grep keys
