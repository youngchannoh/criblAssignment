### Variables ###
dockerImage=cribl_image
environFile=env.list
hostName=agent
bridgNetworkName=cribl_network
localDir=/home/shoretel/docker_containers/cribl
containerDir=/app
fileToRunOnContainer=run_agent.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run -v ${localDir}:${containerDir} --rm  --env-file=${environFile} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
docker run -v ${localDir}:${containerDir} --rm  --env-file=${environFile} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash ${fileToRunOnContainer}