### Variables ###
dockerImage=cribl_image
bridgNetworkName=cribl_network
hostName_t1=target_1
hostName_t2=target_2
hostName_s=splitter
sharedVolume_t1=vol_target_1
sharedVolume_t2=vol_target_2
hostLocalDir_t1=/home/shoretel/docker_containers/cribl/volume/target_1
hostLocalDir_t2=/home/shoretel/docker_containers/cribl/volume/target_2
containerDir=/app/assignment
fileToRunOnContainer_t=run_target.sh
fileToRunOnContainer_s=run_splitter.sh
### Create volumes to sync container to host->local directory.
docker volume create --driver local  --opt type=none --opt device=${hostLocalDir_t1} --opt o=bind ${sharedVolume_t1}
docker volume create --driver local  --opt type=none --opt device=${hostLocalDir_t2} --opt o=bind ${sharedVolume_t2}
### Start Containers
docker run -d -v ${sharedVolume_t1}:${containerDir} --rm --network ${bridgNetworkName} --name ${hostName_t1} -it ${dockerImage} bash  ${fileToRunOnContainer_t}
docker run -d -v ${sharedVolume_t2}:${containerDir} --rm --network ${bridgNetworkName} --name ${hostName_t2} -it ${dockerImage} bash  ${fileToRunOnContainer_t}
docker run -d --rm --network ${bridgNetworkName} --name ${hostName_s} -it ${dockerImage} bash  ${fileToRunOnContainer_s}

