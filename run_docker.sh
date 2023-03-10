#!/bin/bash

docker container rm -f centos7_python


docker run -dit \
   --network=none \
    --privileged \
   --name centos7_python  \
   centos7_python:v1 \
    /usr/sbin/init

#below pipework script can be used to assign IP to container
# br1 is host network bridge
#pipework br1 centos7_python 192.168.1.106/24@192.168.1.1
