#!bin/bash

################################################################################
# File Name          : set_up_quarkdb.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to set up quarkdb for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

clusterid=${1}
hostname=${2}

quarkdb-create --path /var/lib/quarkdb/node-1 --clusterID $clusterid --nodes $hostname:7777

chown -R daemon:daemon /var/lib/quarkdb/node-1
chown -R daemon:daemon /var/log/xrootd

cat > /etc/xrootd/xrootd-quarkdb.cfg << EOF
xrd.port 7777
xrd.protocol redis:7777 libXrdQuarkDB.so
redis.mode raft
redis.database /var/lib/quarkdb/node-1
redis.myself $hostname:7777
redis.password_file /etc/eos.keytab
EOF

install -d -o daemon -g daemon /var/lib/quarkdb
mkdir -p /etc/systemd/system/xrootd@quarkdb.service.d

cat > /etc/systemd/system/xrootd@quarkdb.service.d/override.conf << EOF
[Service]
User=daemon
Group=daemon
EOF

cat > /etc/xrootd/scitokens.cfg << EOF
[Global]
audience = https://wlcg.cern.ch/jwt/v1/any

#[Issuer OSG-Connect]
#issuer = https://wlcg.cloud.cnaf.infn.it/
#base_path = /
#map_subject = False
#default_user = dteam001

[Issuer dteam]
issuer = https://scitokens.org/dteam
base_path = /eos/dteam
map_subject = False
default_user = dteam001
EOF
