### Variables ###
dockerImage=cribl_image
environFile=env.list
hostName=splitter
bridgNetworkName=cribl_network
outsidePort=9992
insidePort=9997
fileToRunOnContainer=run_splitter.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run --detach -p 8080:5000 -t  ${dockerImage}
#docker run -it  ${dockerImage}  /bin/bash
#docker run -p ${outsidePort}:${insidePort} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
docker run --rm --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash  ${fileToRunOnContainer}

