#!/bin/bash
sed -e "s/%ip_server1%/$1/g" hosts_template >hosts
sed -i "s/%ip_server2%/$2/g" hosts
