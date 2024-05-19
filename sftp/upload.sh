#!/bin/bash

opscp='scp -o StrictHostKeyChecking=no -i ~/.ssh/ops2020 -o user=root'

local_Path="/asgc_ui_home/imding1211/.temp/"

remote_Name=${1}
dir_Name=${2}
remote_Path=${3}

$opscp -r $local_Path$dir_Name $remote_Name:$remote_Path