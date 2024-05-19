#!/bin/bash

opskey=ops2020

opssh='ssh -o StrictHostKeyChecking=no -i ~/.ssh/'$opskey' -lroot'

stor_name=${1}
mode=${2}

if [ "$mode" == "hp_pd" ]
then
	$opssh $stor_name ssacli ctrl slot=2 pd all show
elif [ "$mode" == "hp_ld" ]
then
	$opssh $stor_name ssacli ctrl slot=2 ld all show
elif [ "$mode" == "sms_pd" ]
then
	$opssh $stor_name storcli /c0/eall/sall show
fi
