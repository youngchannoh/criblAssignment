#!/bin/bash
### Variables ###
deviceName=/home/shoretel/docker_containers/cribl/volume/target_2
volName=vol_target_2
### The following creates a volume specific for volName which can be used when "docker run..." ###
docker volume create --driver local  --opt type=none --opt device=${deviceName} --opt o=bind ${volName}
