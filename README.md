# cribl Assignment
Well,  it has been a while doing homework :)

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
    ○ Start a container: "target_1"
    ○ Start a container: "target_2"
    ○ Start a container: "splitter"

---

## How to run test cases
    ○ Tool
        § Jenkins
        § Robot Framework with python
    ○ Start a container for "agent" and run test cases automatically
    ○ How to run each test case
        § Run "agent" with a different file (including the file provided from Cribl)
        § Validates if data received on the "Target" nodes are correct.

---      
## Teardown
    ○ Exit the container:  "agent"
    ○ Exit the container: "splitter"
    ○ Exit the container: "target_1"
    ○ Exit the container: "target_2"
    ○ Delete the volume for "target_1"
    ○ Delete the volume for "target_2"
     
---
##  CICD
    ○ Configure GitHub to notify a change to Jenkins
    ○ Jenkins run the above