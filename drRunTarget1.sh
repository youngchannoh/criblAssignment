### Variables ###
dockerImage=cribl_image
environFile=env.list
hostName=target_1
bridgNetworkName=cribl_network
outsidePort=9993
insidePort=9997
localDir=/home/shoretel/docker_containers/cribl/volume/target_1
containerDir=/app/assignment
sharedVolume=vol_target_1
fileToRunOnContainer=run_target.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run --detach -p 8080:5000 -t  ${dockerImage}
#docker run -it  ${dockerImage}  /bin/bash
#docker run -p ${outsidePort}:${insidePort} --rm  --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
#docker run -v ${localDir}:${containerDir} --rm  --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
docker run -v ${sharedVolume}:/app/assignment --rm --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash  ${fileToRunOnContainer}

