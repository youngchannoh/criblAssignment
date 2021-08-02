### Variables ###
dockerImage=cribl_image
environFile=env.list
hostName=target_2
bridgNetworkName=cribl_network
outsidePort=9994
insidePort=9997
sharedVolume=vol_target_2
fileToRunOnContainer=run_target.sh
### -v :This is to sych local and container dir (Reason: RobotFramework to publish result to Jenkins) ###
#docker run --detach -p 8080:5000 -t  ${dockerImage}
#docker run -it  ${dockerImage}  /bin/bash
#docker run -p ${outsidePort}:${insidePort} --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
#docker run --volumes-from target_1 --rm --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash
docker run -v ${sharedVolume}:/app/assignment --rm --network ${bridgNetworkName} --name ${hostName} -it ${dockerImage} bash  ${fileToRunOnContainer}



