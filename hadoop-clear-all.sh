#/bin/bash
#
#
#Autho:
#	Ove
#Date:
#	2018-1-9
#
#清除所有hadoop机用到的临时文件、日志文件、目录
#
#

#Master的主机名
master=master

#Hadoop配置文件目录
HADOOP_CONF=/home/hadoop/hadoop-2.8.3/etc/hadoop

#Hadoop Master中用到的目录
Hadoop_Master_Dir=/stor01/hadoop

#Hadoop 所有Slave中用到的目录
Hadoop_Slave_Dir=/data/hadoop

#删除Master文件和目录
ssh $master "rm -fr $Hadoop_Master_Dir"
echo 删除"$master"主节点完成！

#读取slaves节点的主机名
slaves=$HADOOP_CONF/slaves
while read slave
do
	#删除slave中的文件和目录
	ssh -n $slave "rm -rf $Hadoop_Slave_Dir"
	echo  删除"$slave"从节点完成!
done < "$slaves"
