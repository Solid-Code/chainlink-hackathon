#!/bin/bash

# load configuration
. nodes.config

# get number of nodes
nodes=${#node_names[@]}

# launch each node
for (( i=0; i<${nodes}; i++ ));
do
  path=~/.${node_names[$i]}
  echo $path
  port=$((starting_port + $i))
  if [ ! -d "$path" ]; then
    mkdir $path
  fi
  echo $wallet_password > $path/.password
  echo -e $api_email'\n'$api_password  > $path/.api
  echo  "Launching chainlink node at port " $port
  docker run -d -p $port:6688 \
    -v $path:/chainlink \
    -it \
    --env-file=$(pwd)/nodes.env smartcontract/chainlink local n \
    -p /chainlink/.password \
    -a /chainlink/.api
done