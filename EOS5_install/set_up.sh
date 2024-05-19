#!bin/bash

################################################################################
# File Name          : set_up.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to set up for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

systemctl start fetch-crl-cron
systemctl enable fetch-crl-cron

cp /usr/lib64/libXrdAccSciTokens-5.so /opt/eos/lib64/

mkdir /etc/grid-security/daemon
chown daemon:daemon /etc/grid-security/daemon

file_path=$(dirname $(readlink -f $0))

cp $file_path/grid-mapfile /etc/grid-security/grid-mapfile
cp $file_path/hostcert.pem /etc/grid-security/hostcert.pem
cp $file_path/hostkey.pem /etc/grid-security/hostkey.pem
cp $file_path/hostcert.pem /etc/grid-security/daemon/hostcert.pem
cp $file_path/hostkey.pem /etc/grid-security/daemon/hostkey.pem

chown daemon:daemon /etc/grid-security/daemon/hostcert.pem /etc/grid-security/daemon/hostkey.pem
chown daemon:daemon /etc/grid-security/hostcert.pem /etc/grid-security/hostkey.pem

chmod 600 /etc/grid-security/hostkey.pem /etc/grid-security/daemon/hostkey.pem

cat > /etc/eos.keytab <<EOF
0 u:daemon g:daemon n:eos-test N:5584055516046295042 c:1300139240 e:0 k:a94721fa30d4eac6a6a4ff3425f6836e1607446dd7b268fe022f7448a3ed8d93
EOF

chmod 400 /etc/eos.keytab
chown -R daemon:daemon /etc/eos.keytab

cat > /etc/eos.client.keytab <<EOF
0 u:daemon g:daemon n:eos-test+ N:6927582626958016513 c:1612953522 e:0 f:0 k:4d6faa5829d44b32a19c74e2915d94dd86125bfe7dfffb7c2badcb000f9a8327
EOF

chown daemon:daemon /etc/eos.client.keytab
chmod 600 /etc/eos.client.keytab

cat > /etc/eos.macaroon.secret << EOF
/5ctOfgUpjfDKdHxkxR90AWWn2AmlTkaQ59+7vmJj6aEQVp5VKwN2HwCf1miZvPE
V8mdsCa9MlSb0jY7+n5IQw==
EOF

chown daemon:daemon /etc/eos.macaroon.secret
chmod 400 /etc/eos.macaroon.secret

cat > /etc/cron.d/edg-mkgridmap << EOF
16 1,7,13,19 * * * root (date; /usr/sbin/edg-mkgridmap --output=/etc/grid-security/grid-mapfile --safe) >> /var/log/edg-mkgridmap.log 2>&1
EOF
