#!bin/bash

################################################################################
# File Name          : creat_xrd_fst.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to creat xrd.cf.fst for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

hostname=${1}

cat > /etc/xrd.cf.fst << EOF
###########################################################
set MGM=\$EOS_MGM_ALIAS
###########################################################

fstofs.qdbcluster $hostname:7777
fstofs.qdbpassword_file /etc/eos.keytab

xrootd.fslib -2 libXrdEosFst.so
xrootd.async off nosf
xrd.network keepalive
xrootd.redirect \$(MGM):1094 chksum

###########################################################
xrootd.seclib libXrdSec.so
sec.protocol unix
sec.protocol sss -c /etc/eos.keytab -s /etc/eos.keytab
sec.protbind * only unix sss
###########################################################
all.export / nolock
all.trace none
all.manager localhost 2131
#ofs.trace open
###########################################################
xrd.port 1095
ofs.persist off
ofs.osslib libEosFstOss.so
ofs.tpc pgm /opt/eos/xrootd/bin/xrdcp
###########################################################
# this URL can be overwritten by EOS_BROKER_URL defined /etc/sysconfig/xrd
fstofs.broker root://$hostname:1097//eos/
fstofs.autoboot true
fstofs.quotainterval 10
fstofs.metalog /var/eos/md/
#fstofs.authdir /var/eos/auth/
#fstofs.trace client
###########################################################

#-------------------------------------------------------------------------------
# Configuration for XrdHttp http(s) service on port 11000
#-------------------------------------------------------------------------------
#if exec xrootd
#   xrd.protocol XrdHttp:11000 /usr/lib64/libXrdHttp-4.so
#   http.exthandler EosFstHttp /usr/lib64/libEosFstHttp.so none
#   http.cert /etc/grid-security/daemon/host.cert
#   http.key /etc/grid-security/daemon/privkey.pem
#   http.cafile /etc/grid-security/daemon/ca.cert
#fi

xrd.protocol XrdHttp:9001 /usr/lib64/libXrdHttp.so
http.exthandler EosFstHttp /usr/lib64/libEosFstHttp.so none
http.exthandler xrdtpc /usr/lib64/libXrdHttpTPC.so
http.trace all

http.cert /etc/grid-security/daemon/hostcert.pem
http.key /etc/grid-security/daemon/hostkey.pem
http.cadir /etc/grid-security/certificates
EOF