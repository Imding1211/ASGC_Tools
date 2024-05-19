#!/bin/bash

opscp='scp -o StrictHostKeyChecking=no -i ~/.ssh/ops2020 -o user=root'

local_Path="/asgc_ui_home/imding1211/.temp/"

remote_Name=${1}
remote_Path=${2}

$opscp -r $remote_Name:$remote_Path $local_Path
