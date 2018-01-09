#/bin/bash
#
#
#Autho:
#	Ove
#Date:
#	2018-1-9
#
#创建所有hadoop目录的目录并格式化hdfs
#
#

#Master的主机名
master=master

#Hadoop安装目录
HADOOP_HOME=/home/hadoop/hadoop-2.8.3

#Hadoop配置文件目录
HADOOP_CONF=$HADOOP_HOME/etc/hadoop

#Master中JobHistory的临时文件目录，用于MapReduce Job读写
JobHistory_Tmp_Dir=/stor01/hadoop/hadoop/jobhistoryserver/tmp

#MasterJobHistory Mapreduce的完成目录
JobHistory_Done_Dir=/stor01/hadoop/hadoop/jobhistoryserver/done

#Master中存放namenode中的namespace和log文件的路径
NameNode_Dir=/stor01/hadoop/hadoop/namenode

#Slave中存放datanode中的数据的目录
DataNode_Dir=/data/hadoop/hadoop/datanode

#Slave中用于NodeManager中指定的用于存储中间文件的路径
NodeManger_Intermediate=/data/hadoop/hadoop/nodemanager/intermediate_data

#Slave中用于NodeManager日志存储的路径
NodeManager_Log=/data/hadoop/hadoop/nodemanager/log


#创建Master文件和目录
ssh $master "mkdir -p $JobHistory_Tmp_Dir $JobHistory_Done_Dir $NameNode_Dir"
echo $master 主节点目录 $JobHistory_Tmp_Dir，$JobHistory_Done_Dir，$NameNode_Dir 创建完成！

#读取slaves节点的主机名
slaves=$HADOOP_CONF/slaves
while read slave
do
	#创建slave中的目录
	ssh -n $slave "mkdir -p $DataNode_Dir $NodeManger_Intermediate $NodeManager_Log"
	echo  $slave  从节点目录 $DataNode_Dir，$NodeManger_Intermediate，$NodeManager_Log 创建完成!
done < "$slaves"

#格式化hdfs
ssh master "$HADOOP_HOME/bin/hdfs namenode -format"
echo "hdfs格式化完成!"
