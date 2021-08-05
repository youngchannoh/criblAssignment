#!/bin/bash
### Variables ###
sharedVolume_t1=vol_target_1
sharedVolume_t2=vol_target_2
hostName_t1=target_1
hostName_t2=target_2
hostName_s=splitter
bridgNetworkName=cribl_network
echo "### Stopping running docker containers : This would remove docker too since they were started using --rm option"
### It doesn't need to remove agent since it would be removed after running test.
docker stop  ${hostName_t1}
docker stop  ${hostName_t2}
docker stop  ${hostName_s}
echo
echo "### Teardown volumes ###"
docker volume rm ${sharedVolume_t1}
docker volume rm ${sharedVolume_t2}
echo
echo "### Delete a network"
docker network rm ${bridgNetworkName}

