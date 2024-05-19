#!/bin/bash

opssh='ssh -o StrictHostKeyChecking=no -i ~/.ssh/ops2020 -lroot'

stor_name=${1}
pool_name=${2}
fail_disk=${3}

$opssh $stor_name zpool detach $pool_name $fail_disk > /dev/null 2>&1
$opssh $stor_name zpool add $pool_name spare $fail_disk > /dev/null 2>&1
