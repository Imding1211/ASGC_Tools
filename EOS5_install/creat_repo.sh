#!bin/bash

################################################################################
# File Name          : creat_repo.sh
# Last Modified Date : 2023-06-05
# Author             : Ding
# Description        : This script is used to creat repository for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

cat > /etc/yum.repos.d/eos.repo << EOF
[eos-diopside]
name=EOS 5.0 Version
baseurl=https://storage-ci.web.cern.ch/storage-ci/eos/diopside/tag/testing/el-7/x86_64/
gpgcheck=0

[eos-diopside-depend]
name=EOS 5.0 Dependencies
baseurl=https://storage-ci.web.cern.ch/storage-ci/eos/diopside-depend/el-7/x86_64/
gpgcheck=0

[eos-citrine]
name=EOS 4.0 Version
baseurl=https://storage-ci.web.cern.ch/storage-ci/eos/citrine/tag/el-7/x86_64/
gpgcheck=0

[eos-citrine-dep]
name=EOS 4.0 Dependencies
baseurl=https://storage-ci.web.cern.ch/storage-ci/eos/citrine-depend/el-7/x86_64/
gpgcheck=0
EOF

cat > /etc/yum.repos.d/xrootd.repo <<EOF
[xrootd-stable]
name=XRootD Stable repository
baseurl=http://xrootd.org/binaries/stable/slc/7/x86_64 http://xrootd.cern.ch/sw/repos/stable/slc/7/x86_64
gpgcheck=1
enabled=1
protect=0
gpgkey=http://xrootd.cern.ch/sw/releases/RPM-GPG-KEY.txt
EOF

cat > /etc/yum.repos.d/quarkdb.repo <<EOF
[quarkdb-stable]
name=QuarkDB repository [stable]
baseurl=http://storage-ci.web.cern.ch/storage-ci/quarkdb/tag/el7/x86_64/
enabled=1
gpgcheck=False
EOF

cat > /etc/yum.repos.d/EGI-trustanchors.repo <<EOF
[EGI-trustanchors]
baseurl=http://repository.egi.eu/sw/production/cas/1/current/
gpgcheck=1
gpgkey=http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3
name=CA repository
EOF

cat > /etc/yum.repos.d/wlcg.repo <<EOF
[wlcg]
baseurl=http://linuxsoft.cern.ch/wlcg/centos7/x86_64
enabled=1
gpgcheck=1
gpgkey=http://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg
name=WLCG Repository
priority=1
protect=1
EOF
