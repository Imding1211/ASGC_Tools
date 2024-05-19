#!bin/bash

################################################################################
# File Name          : install_package.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to yum install package for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

yum install epel-release -y
yum install eos-client -y
yum install eos-test -y
yum install eos-nginx -y
yum install xrootd -y
yum install xrootd-devel -y
yum install edg-mkgridmap -y
yum install xrootd-voms -y
yum install quarkdb quarkdb-debuginfo redis -y
yum install ca-policy-egi-core -y
yum install xrootd-scitokens -y
yum install wlcg-voms-ops -y
yum install wlcg-voms-lhcb -y
yum install wlcg-voms-alice -y
yum install wlcg-voms-cms -y
yum install wlcg-voms-atlas -y
yum install wlcg-voms-dteam -y
yum install wlcg-iam-vomses-cms -y
yum install wlcg-iam-lsc-atlas -y
yum install wlcg-iam-lsc-cms -y
yum install fetch-crl -y
