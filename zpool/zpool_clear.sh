#!/bin/bash

opskey=ops2020

opssh='ssh -o StrictHostKeyChecking=no -i ~/.ssh/'$opskey' -lroot'

stor_name=${1}
raid_name=${2}

$opssh $stor_name zpool clear data01 $raid_name

