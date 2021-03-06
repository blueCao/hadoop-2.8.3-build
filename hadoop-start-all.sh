#/bin/bash
#
#Author:
#	Ove
#Date:
#	2018-1-9
#
#启动所有的hadoo进程
#
#
#

HADOOP_PREFIX=/home/hadoop/hadoop-2.8.3
HADOOP_CONF_DIR=/home/hadoop/hadoop-2.8.3/etc/hadoop

#Master打开某一台机器的NameNode as hdfs
#$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

#Slave打开某一台机器的DataNode as hdfs
#$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode

#一次性打开所有集群的hdfs进程
$HADOOP_PREFIX/sbin/start-dfs.sh

#Master打开某一台机器的ResourceManager as yarn
#$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager

#Slave打开某一台机器的NodeManager as yarn
#$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager

#一次性打开所有集群的yarn进程
$HADOOP_PREFIX/sbin/start-yarn.sh

#Master打开JobHistory Server
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
