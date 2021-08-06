#!/bin/bash
### Variables ###
rootDir="$PWD"
dockerImage=cribl_image
environFile=env.list
hostName=agent
bridgNetworkName=cribl_network
containerDir=/app
fileToRunOnContainer=run_agent.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run -v ${rootDir}:${containerDir} --rm  --env-file=${environFile} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
docker run -v ${rootDir}:${containerDir} --rm  --env-file=${environFile} --network ${bridgNetworkName} --name ${hostName}  ${dockerImage} bash ${fileToRunOnContainer}