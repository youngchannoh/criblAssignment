#!/bin/bash
echo "##### Creating image #####"
bash drBuild.sh
sleep 5
echo 
echo "##### Set up #####"
bash drSetup.sh
sleep 5
echo  
echo "##### Run test #####"
bash drTests.sh
sleep 5
echo  
echo "##### Tear down #####"
bash drTeardown.sh
echo
echo  "### Deleting docker image ###"
bash drDeleteImage.sh
