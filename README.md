# cribl Assignment
 

### version
    1.0.0

### Goal
    Validate if data received by two "Target" nodes matches the data from "Agent" node.

###  Tool
    * Jenkins
    * Github
    * Unix VM
        * 1 docker image
        * 4 docker containers from the above image.
---

# How to run test cases including setup and tear-down

## From Ubuntu VM
    * Clone this project to your UNix VM.
    
    * Run the following command (This is the master!)
     => "bash drAll.sh"
    * The above will execute the following
        1. drBuild.sh
        2. drSetup.sh
        3. drTest.sh
        4. drTeardown.sh
        5. drDeleteImage.sh
    1 drBuild.sh
        1) This would create a docker image: "cribl_image"
    2. drSetup.sh
        1) Create a volume for "target_2"
        2) Create a volume for "target_2"
        3) Create a network : "cribl_network"
        4) Start a container: "target_1"
        5) Start a container: "target_2"
        6) Start a container: "splitter"
    3 drTests.sh
        1) Start a container: "agent"
        2) Run test cases
        3) Exit the container after finishing the test.
    4 drTeardown.sh
        1) Exit the container: "splitter"
        2) Exit the container: "target_1"
        3) Exit the container: "target_2"
        4) Delete the volume for "target_1"
        5) Delete the volume for "target_2"
        6) Delete the network : "cribl_network"
    5. drDeleteImage.sh
        1) Delete the image : "cribl_image"
 
## From Jenkins
    1. Create a Jenkins's node (your unix VM)
        1) My Ubuntu version: "Ubuntu 16.04.2 LTS"
    2. Create a Jenkins' job as follows.
        1) Add the following to Command text box 
        => cd "to your cloned directory"
        => bash drAll.sh
        2) Add the following post build action.
            a. "Publish Robot framework test results"
    3. The Test result 
        1) It would appear on Jenkins as html format.
        2) It can be sent as an attachment to an email.

---

# Test Summary
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
#  CICD

## From Github
    * Create a webhook to your "jenkins server"
        1) payload url: http://"your Jenkins Server":8080/github-webhook/
        2) To trigger: just push event
    * This configuration depends on a setup of your Jenkins server.

## From Jenkins
    * Create a jenkins job to do the following
        1) Use "Githup and Git plug-in" to get "GitHub hook trigger"
        2) Clone this Github project to your Unix node.
        3) Run "bash drAll.sh"
    * This configuration depends on a setup of your Jenkins server.
     
   
    
    
