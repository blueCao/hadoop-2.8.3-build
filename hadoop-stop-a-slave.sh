#/bin/bash
#
#Author:
#	Ove
#Date:
#	2018-1-9
#
#关闭一台Slave节点的hadoo进程
#
#
#

HADOOP_PREFIX=/home/hadoop/hadoop-2.8.3
HADOOP_CONF_DIR=/home/hadoop/hadoop-2.8.3/etc/hadoop

#关闭某一台机器的DataNode as hdfs
$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode

#关闭某一台机器的NodeManager as yarn
$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR stop nodemanager
