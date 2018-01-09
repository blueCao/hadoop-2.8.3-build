#/bin/bash
#
#Author:
#	Ove
#Date:
#	2018-1-9
#
#关闭所有的hadoo进程
#
#
#

HADOOP_PREFIX=/home/hadoop/hadoop-2.8.3
HADOOP_CONF_DIR=/home/hadoop/hadoop-2.8.3/etc/hadoop

#Master闭某一台机器的NameNode as hdfs
#$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode

#Slave关闭某一台机器的DataNode as hdfs
#$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode

#一次性关闭所有集群的hdfs进程
$HADOOP_PREFIX/sbin/stop-dfs.sh

#Master关闭某一台机器的ResourceManager as yarn
#$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager

#Slave关闭某一台机器的NodeManager as yarn
#$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR stop nodemanager

#一次性关闭所有集群的yarn进程
$HADOOP_PREFIX/sbin/stop-yarn.sh

#Master关闭JobHistory Server
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR stop historyserver
