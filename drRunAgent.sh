### Variables ###
dockerImage=cribl_image
environFile=env.list
hostName=agent
bridgNetworkName=cribl_network
outsidePort=9991
insidePort=9997
localDir=/home/shoretel/docker_containers/cribl/volume
containerDir=/app/volume
fileToRunOnContainer=run_agent.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run --detach -p 8080:5000 -t  ${dockerImage}
#docker run -it  ${dockerImage}  /bin/bash
#docker run -p ${outsidePort}:${insidePort} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
#docker run --volumes-from target_1 --rm --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
#docker run -v ${localDir}:${containerDir} --rm  --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash  ${fileToRunOnContainer}
docker run -v ${localDir}:${containerDir} --rm  --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
