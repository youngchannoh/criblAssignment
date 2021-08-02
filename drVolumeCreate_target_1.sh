#!/bin/bash
docker volume create --driver local  --opt type=none --opt device=/home/shoretel/docker_containers/cribl/volume/target_1 --opt o=bind vol_target_1
