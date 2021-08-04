#!/bin/bash
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