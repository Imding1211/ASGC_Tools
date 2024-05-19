#!/bin/bash

opssh='ssh -o StrictHostKeyChecking=no -i ~/.ssh/ops2020 -lroot'

stor_name=${1}

$opssh $stor_name ls /dev/disk/by-id/ | grep -v "part" | grep -i "wwn"

echo "End"

$opssh $stor_name ls /dev/disk/by-id/ | grep -i "part2" | grep -i "wwn"
