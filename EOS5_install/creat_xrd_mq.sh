#!bin/bash

################################################################################
# File Name          : creat_xrd_mq.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to creat xrd.cf.mq for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

hostname=${1}

cat > /etc/xrd.cf.mq << EOF
######################### Broker OFS ########################
mq.qdbcluster $hostname:7777
mq.qdbpassword_file /etc/eos.keytab

xrootd.fslib libXrdMqOfs.so
all.export /eos/ nolock
all.role server
xrootd.async off nosf
#############################################################
# SSS authentication
xrootd.seclib libXrdSec.so
sec.protocol sss -c /etc/eos.keytab -s /etc/eos.keytab
sec.protocol unix
sec.protbind * only sss unix

#############################################################
# allow upto 1024 threads
xrd.sched mint 16 maxt 1024 idle 128
# run on port 1097
xrd.port 1097
#############################################################
# keepalive + idle timeout
xrd.network keepalive
xrd.timeout idle 120
mq.maxmessagebacklog 100000
mq.maxqueuebacklog 50000
mq.rejectqueuebacklog 100000

#############################################################
# low|medium|high as trace levels
mq.trace low
#############################################################
mq.queue /eos/
EOF