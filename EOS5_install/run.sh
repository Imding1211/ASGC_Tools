#!bin/bash

################################################################################
# File Name          : run.sh
# Last Modified Date : 2023-9-13
# Author             : Ding
# Description        : This script run all script to install EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

clusterid=${1}
hostname=${2}
INSTANCE_NAME=${3}
file_path=$(dirname $(readlink -f $0))

bash $file_path/creat_repo.sh
bash $file_path/install_package.sh
bash $file_path/set_up.sh
bash $file_path/set_up_quarkdb.sh $clusterid $hostname
bash $file_path/creat_eos_env.sh $hostname $INSTANCE_NAME
bash $file_path/creat_xrd_mq.sh $hostname
bash $file_path/creat_xrd_mgm.sh $hostname
bash $file_path/creat_xrd_fst.sh $hostname
bash $file_path/set_up_firewalld.sh
