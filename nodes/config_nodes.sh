#!/bin/bash

# load configuration
. nodes.config

# get number of nodes
nodes=${#node_names[@]}

# send external adapter config to each node
for (( i=0; i<${nodes}; i++ ));
do
  path=~/.${node_names[$i]}
  port=$((starting_port + $i))
 
  curl -c $path/cookiefile \
    -d '{"email":"'$api_email'", "password":"'$api_password'"}' \
    -X POST -H 'Content-Type: application/json' \
     http://localhost:$port/sessions

  curl -b $path/cookiefile -X POST \
    -H 'Content-Type: application/json' \
    -d '{"name":"'$external_adapter_name'","url":"'$external_adapter_URL'"}' \
    http://localhost:$port/v2/bridge_types

  curl -b ~/.chainlink-node_1/cookiefile http://localhost:6688/v2/user/balances \
    | python -m json.tool \
    | grep '\"joke\"' \
    | cut -d ':' -f 2 \
    | sed 's/&quot;/\"/g'

  echo $wallet_password > $path/.password
done