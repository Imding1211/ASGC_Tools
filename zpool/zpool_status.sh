#!/bin/bash

opskey=ops2020

opssh='ssh -o StrictHostKeyChecking=no -i ~/.ssh/'$opskey' -lroot'

stor_name=${1}

$opssh $stor_name zpool status

