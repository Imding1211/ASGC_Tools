#!bin/bash

################################################################################
# File Name          : creat_eos_env.sh
# Last Modified Date : 2023-07-06
# Author             : Ding
# Description        : This script is used to creat eos_env for EOS5.
# Version            : 1.0
# Dependencies       : None
# License            : None
# Contact            : None
################################################################################

hostname=${1}
INSTANCE_NAME=${2}

cat > /etc/sysconfig/eos_env << EOF
#-------------------------------------------------------------------------------
# File: eos_env.example
# Authors: Ivan Arizanovic - ComTrade Solutions Engineering
#-------------------------------------------------------------------------------

# ************************************************************************
# * EOS - the CERN Disk Storage System                                   *
# * Copyright (C) 2018 CERN/Switzerland                                  *
# *                                                                      *
# * This program is free software: you can redistribute it and/or modify *
# * it under the terms of the GNU General Public License as published by *
# * the Free Software Foundation, either version 3 of the License, or    *
# * (at your option) any later version.                                  *
# *                                                                      *
# * This program is distributed in the hope that it will be useful,      *
# * but WITHOUT ANY WARRANTY; without even the implied warranty of       *
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *
# * GNU General Public License for more details.                         *
# *                                                                      *
# * You should have received a copy of the GNU General Public License    *
# * along with this program.  If not, see <http://www.gnu.org/licenses/>.*
# ************************************************************************

# Should we run with another limit on the core file size other than the default?
DAEMON_COREFILE_LIMIT=unlimited

# Preload jemalloc
LD_PRELOAD=/usr/lib64/libjemalloc.so.1

# Disable the KRB5 replay cache
KRB5RCACHETYPE=none

# What roles should the xroot daemon run for. For each role you can overwrite
# the default options using a dedicate sysconfig file
# e.g. /etc/sysconfig/xrd.<role>. The role based mechanism allows for
# multiple xrd's running with different options to be controlled via
# the same systemd script

#-------------------------------------------------------------------------------
# EOS roles - Systemd Services
#-------------------------------------------------------------------------------
XRD_ROLES="mq mgm fst"

#-------------------------------------------------------------------------------
# EOS
#-------------------------------------------------------------------------------
# The fully qualified hostname of current MGM
EOS_MGM_HOST="$hostname"

# The fully qualified hostname of target MGM
EOS_MGM_HOST_TARGET="$hostname"

# The EOS instance name
EOS_INSTANCE_NAME="$INSTANCE_NAME"

# The EOS configuration to load after daemon start
EOS_AUTOLOAD_CONFIG=default

# The EOS broker URL
EOS_BROKER_URL="root://$hostname:1097//eos/"

# The EOS host geo location tag used to sort hosts into geographical (rack) locations
EOS_GEOTAG="TW"

# The fully qualified hostname of MGM master1
EOS_MGM_MASTER1="$hostname"

# The fully qualified hostname of MGM master2
EOS_MGM_MASTER2="$hostname"

# The alias which selects master 1 or 2
EOS_MGM_ALIAS="$hostname"
EOS_FUSE_MGM_ALIAS="$hostname"

# The mail notification in case of fail-over
# EOS_MAIL_CC="apeters@mail.cern.ch"
# EOS_NOTIFY="mail -s `date +%s`-`hostname`-eos-notify \$EOS_MAIL_CC"

# Enable core dumps initiated internally
# EOS_CORE_DUMP

# Disable shutdown/signal handlers for debugging
# EOS_NO_SHUTDOWN

# Enable coverage report signal handler
# EOS_COVERAGE_REPORT

# Enable QoS support
# EOS_ENABLE_QOS=""

# Enable Converter Engine
# EOS_CONVERTER_DRIVER=1

# Allow UTF-8 path names excluding only CR,LF
# EOS_UTF8=""

# Add secondary group information from database/LDAP (set to 1 to enable)
# EOS_SECONDARY_GROUPS=0

# Do subtree accounting on directories (set to 1 to enable)
# EOS_NS_ACCOUNTING=0

# Do sync time propagation (set to 1 to enable)
# EOS_SYNCTIME_ACCOUNTING=0

# Use std::shared_timed_mutex for the RWMutex implementation - uncomment to
# enable.
# EOS_USE_SHARED_MUTEX=1

# By default statvfs reports the total space if the path deepness is < 4
# If you want to report only quota accouting you can define
# EOS_MGM_STATVFS_ONLY_QUOTA=1

# If variable defined then enable the use of xrootd connection pool i.e.
# create/share different physical connections for transfers to the same
# destination xrootd server. By default this is disabled.
# This applies both in context of the MGM server when it comes to TPC jobs and
# also on the FST server for FST to FST transfers.
# EOS_XRD_USE_CONNECTION_POOL=1

# When xrootd connection pool is enabled, one can control the maximum number
# of physical connection that can be established with the destination server.
# The min value is 1 and the max 1024. By default this 1024.
# EOS_XRD_CONNECTION_POOL_SIZE=1024

#-------------------------------------------------------------------------------
# FST Configuration
#-------------------------------------------------------------------------------

# Disable 'sss' enforcement to allow generic TPC
# EOS_FST_NO_SSS_ENFORCEMENT=1

# Network interface to monitor (default eth0)
# EOS_FST_NETWORK_INTERFACE="eth0"

# Stream timeout for operations
# EOS_FST_STREAM_TIMEOUT=300

# Specify in seconds how often FSTs should query for new delete operations
# EOS_FST_DELETE_QUERY_INTERVAL=300

# Disable fast boot and always do a full resync when a fs is booting
# EOS_FST_NO_FAST_BOOT=0 (default off)

# If variable defined then enable the use of xrootd connection pool i.e.
# create/share different physical connections for queries done from the FST
# to the MGM in the CallManager method. By default this is disabled.
# EOS_FST_CALL_MANAGER_XRD_POOL=1

# If CallManager xrootd connection pool is enabled one can set the maxium size
# of the pool of connections. The min value is 1, the max value is 32. By default
# the value is 10.
# EOS_FST_CALL_MANAGER_XRD_POOL_SIZE=10

# If variable defined use asynchronous (double-buffered) reading in TPCs - By default
# it is undefined = disabled
# EOS_FST_TPC_READASYNC=1

# Modify the TPC key validity which by default is 120 seconds
# EOS_FST_TPC_KEY_VALIDITY_SEC=120

# Store FMD database on the same partition as the data disk
# EOS_FST_FMD_ON_DATA_DISK=0

#-------------------------------------------------------------------------------
# HTTPD Configuration
#-------------------------------------------------------------------------------
# HTTP server ports

# MGM - set to 0 to disable HTTP
EOS_MGM_HTTP_PORT=9000

# FST - set to 0 to disable HTTP
EOS_FST_HTTP_PORT=9001

# HTTP uses by default one thread per connection
# EOS_HTTP_THREADPOOL="threads"

# Use EPOLL and 16 threads
EOS_HTTP_THREADPOOL="epoll"
EOS_HTTP_THREADPOOL_SIZE=16

# Memory buffer size per connection
# EOS_HTTP_CONNECTION_MEMORY_LIMIT=134217728 (default 128M)
EOS_HTTP_CONNECTION_MEMORY_LIMIT=4194304

# Timeout after which an idle connection is considered to be closed (default 2 min)
# EOS_HTTP_CONNECTION_TIMEOUT=120

#-------------------------------------------------------------------------------
# GRPC Configuration
#-------------------------------------------------------------------------------

# GRPC port - set to 0 toi disable GRPC
# EOS_MGM_GRPC_PORT=50051

# GRPC security - define to enable SSL server
# EOS_MGM_GRPC_SSL_CERT
# EOS_MGM_GRPC_SSL_KEY
# EOS_MGM_GRPC_SSL_CA

#-------------------------------------------------------------------------------
# FUSEX Configuration
#-------------------------------------------------------------------------------

# Listener port of the ZMQ server used by FUSEx)
# EOS_MGM_FUSEX_PORT=1100

# Maximum number of 'listable' children
# EOS_MGM_FUSEX_MAX_CHILDREN=32768

#-------------------------------------------------------------------------------
# Federation Configuration
#-------------------------------------------------------------------------------

# The host[:port] name of the meta manager (global redirector)
# EOS_FED_MANAGER=eos.cern.ch:1094

# The port of the PSS xrootd server
# EOS_PSS_PORT=1098

# The hostname[:port] of the EOS MGM service
# EOS_PSS_MGM=\$EOS_MGM_ALIAS:1094

# The path which should be proxied (/ for all)
# EOS_PSS_PATH=/

#-------------------------------------------------------------------------------
# Test Configuration
#-------------------------------------------------------------------------------

# Mail notification for failed tests
# EOS_TEST_MAILNOTIFY=apeters@mail.cern.ch

# SMS notification for failed tests
# EOS_TEST_GSMNOTIFY="0041764875002@mail2sms.cern.ch"

# Instance name = name of directory at deepness 2 /eos/<instance>/
# EOS_TEST_INSTANCE="dev"

# MGM host redirector
# EOS_TEST_REDIRECTOR=localhost

# Local test output directory
# EOS_TEST_TESTSYS=/tmp/eos-instance-test

# Time to lock re-sending of SMS for consecutively failing tests
# EOS_TEST_GSMLOCKTIME=3600

# Max. time given to the test to finish
# EOS_TEST_TESTTIMESLICE=600

#-------------------------------------------------------------------------------
# QuarkDB Configuration
#-------------------------------------------------------------------------------
EOS_USE_QDB_MASTER=1

# QuarkDB Hostport
# EOS_QUARKDB_HOSTPORT=localhost:9999

# QuarkDB Password
# EOS_QUARKDB_PASSWD=password_must_be_atleast_32_characters

#-------------------------------------------------------------------------------
# Archive configuration
#-------------------------------------------------------------------------------

# Set the root destination for all archives beloging to this instance
# EOS_ARCHIVE_URL=root://castorpps.cern.ch//user/cern.ch/c3/archive/

# Set the CASTOR service class (svcClass) for all file transfers to CASTOR
# EOS_ARCHIVE_SVCCLASS=default

#-------------------------------------------------------------------------------
# MGM TTY Console Broadcast Configuration
#-------------------------------------------------------------------------------

# define the log file where you want to grep
EOS_TTY_BROADCAST_LISTEN_LOGFILE="/var/log/eos/mgm/xrdlog.mgm"

# define the log file regex you want to broad cast to all consoles
EOS_TTY_BROACAST_EGREP="\"CRIT|ALERT|EMERG|PROGRESS\""

#-------------------------------------------------------------------------------
# MGM Namespace Preset Size - this can safe memory for large namespaces if you
# know an upper limit for the namespace size
#-------------------------------------------------------------------------------

# EOS_NS_DIR_SIZE=1000000
# EOS_NS_FILE_SIZE=1000000

# ------------------------------------------------------------------
# MGM Boot options
# ------------------------------------------------------------------
# uncomment to avoid mmaping a changelog file
# EOS_NS_BOOT_NOMMAP

# uncomment to speed up the scanning phase skipping CRC32 computation
# EOS_NS_BOOT_NOCRC32

# uncomment to allow a multi-threaded boot process using maximum number of cores available
# EOS_NS_BOOT_PARALLEL


# ------------------------------------------------------------------
# MGM FUSE configuration
# ------------------------------------------------------------------

# uncomment to change the minimum needed size available to create a new file
# EOS_MGM_FUSE_BOOKING_SIZE = 5368709120


# ------------------------------------------------------------------
# MGM 'xrdfs query space' configuration
# ------------------------------------------------------------------

# uncoment to set the EOS space name to be used by 'xrdfs query space' commands
# that do not explicitly specify an EOS space name
# EOS_MGM_STATVFS_DEFAULT_SPACE="default"

# ------------------------------------------------------------------
# MGM Directory Listing Cache configuration

# set to 0 to disable listing cache for 'xrdfs ls' and 'eos ls', or a number with the number of dirs to cache
# EOS_MGM_LISTING_CACHE=1024

# Set Xrootd Log level
# XRD_LOGLEVEL=Dump
EOF
