#!bin/bash

################################################################################
# File Name          : set_up_firewalld.sh
# Last Modified Date : 2023-09-11
# Author             : Ding
# Description        : This script is used to set up firewalld for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

cat > /etc/firewalld/services/xrootd-dav.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="8000"/>
  <port protocol="tcp" port="9000"/>
</service>
EOF

cat > /etc/firewalld/services/xrootd-fst-davs.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="9001"/>
</service>
EOF

cat > /etc/firewalld/services/xrootd-fst.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="1095"/>
</service>
EOF

cat > /etc/firewalld/services/xrootd-mgm.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="1094"/>
</service>
EOF

cat > /etc/firewalld/services/xrootd-mq.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="1097"/>
</service>
EOF

cat > /etc/firewalld/services/xrootd-qdb.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<service>
  <port protocol="tcp" port="7777"/>
</service>
EOF

cat > /etc/firewalld/zones/public.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <service name="ssh"/>
  <service name="dhcpv6-client"/>
  <service name="xrootd-dav"/>
  <service name="xrootd-mgm"/>
  <service name="xrootd-mq"/>
  <service name="xrootd-fst"/>
  <service name="xrootd-qdb"/>
  <service name="xrootd-fst-davs"/>
  <port protocol="udp" port="7001"/>
  <port protocol="tcp" port="5666"/>
</zone>
EOF

firewall-cmd --reload

