# cribl Assignment
Well,  it has been a while doing homework :) 

## version
1.0.0

---
## Goal
Validate if data received on the 2 "Target" nodes matches the one from "Agent" node.

---
##  Tool
    ○ Jenkins
        § This would send a command to the following Ubuntu host
    ○ Ubuntu host
        § 1 docker image
        § 4 docker containers from the above image.
---
## How to run test cases including setup and tear-down
# from Ubuntu VM
    * Run the following command
    => bash drSetup_Tests_Teardown.sh
    * The above will start the following
        1. drSetup.sh
        2. drTest.sh
        3. drTeardown.sh
    * drSetup.sh
        1. Create a volume for "target_2"
        2. Create a volume for "target_2"
        3. Start a container: "target_1"
        4. Start a container: "target_2"
        5. Start a container: "splitter"
    * drTest.sh
        1. Start a container: agent
        2. Run test cases
        3. Exit the container after finishing the test.
    * drTeardown.sh
        1. Exit the container: "splitter"
        2. Exit the container: "target_1"
        3. Exit the container: "target_2"
        4. Delete the volume for "target_1"
        5. Delete the volume for "target_2"
 
# from Jenkins
1. Create a Jenkins's node to your unix VM
    1) My Ubuntu version: "Ubuntu 16.04.2 LTS"
2. Create a Jenkins' job to send the following command to the VM
    => cd /home/shoretel/docker_containers/cribl
    => bash drSetup_Tests_Teardown.sh
3. The Test result 
    1) It would appear on Jenkins
    2) It can be sent as an ttachment to an email.

---

## Test Summary
1. Framework: "Robot Framework"
    1) Test Cases: ../volume/robotTestCases/cirbleTests_usingDD.robot
2. It uses "Data Driver" to run multiple test cases using template/csv
    1) csv file (../volume/robotTestCases/testData/testCases.csv)
3. The test result would appears as follows.
    1) Jenkins:  Detailed summary (log.html)
    2) Each test would create a csv file which can be found under
    -> .../cribl/volume/robotTestCases/results/
4. New test cases with a new input file can be added as follows.
    1) Assume you have a new file : some_complicated_file.log
    2) Copy the file to .../cribl/asignment/agent/input/
    3) Add a new entry to .../cribl/volume/robotTestCases/testData/testCases.csv
    => cribl->some_complicated_file.log;some_complicated_file.log;
    
     
---
##  CICD
    ○ Configure GitHub to notify a change to Jenkins
    ○ Jenkins run the above
    * ToDo
    
    
    
