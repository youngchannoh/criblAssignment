#!/bin/sh
echo "== Deleting all Robot Framework logs from a previous test =="
rm /app/volume/robotTestCases/results/*
echo "== Show files on results directory after deleting all. =="
cd /app/volume/robotTestCases/results/
ls -al

echo "== Running robotFramework tests under robotTestCases directory  =="
cd /app/volume/robotTestCases/
python3 -m robot.run  -d /app/volume/robotTestCases/results/  /app/volume/robotTestCases/cribleTests_usingDD.robot

