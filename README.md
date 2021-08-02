# criblAssignment
The following is how to run this project.

## version
1.0.0

---
## Goal
Validate if data received on the 2 "Target" nodes matchs with the one from "Agent" node.

---
##  Tool
    ○ Jenkins
        § This would send a command to the following Ubuntu host
    ○ Ubuntu host
        § 1 docker image
        § 4 docker containers from the above image.
---
## Setup 
    ○ Create a docker image named "cribl_image"
    ○ Create a volume for "target_1"
    ○ Create a volume for "target_2"
    ○ Docker run for "target_1"
    ○ Docker run for "target_2"
    ○ Docker run for "splitter"

---

## How to run test case
    ○ Run test cases using 
        § Jenkins
        § Robot Framework with python
    ○ Docker run for "agent" (This has all test cases)
    ○ Test Case
        § Run "agent" with different files (including the file provided from Cribl)
        § Validates if data received on the "Target" nodes are correct.

---      
## Teardown
    ○ Clear "agent"
    ○ Clear "splitter"
    ○ Clear "target_1"
    ○ Clear "target_2"
    ○ Delete a volume for "target_1"
    ○ Delete a volume for "target_2"
     
---
##  CICD
    ○ Configure GitHub to notify a change to Jenkins
    ○ Jenkins run the above