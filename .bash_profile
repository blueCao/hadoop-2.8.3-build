# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#设置历史记录的条数1万
export HISTSIZE=10000

#zookeeper
export ZOOCFGDIR=/home/hadoop/zookeeper-3.3.6/conf
export ZOOBINDIR=/home/hadoop/zookeeper-3.3.6/bin
export ZOOKEEPER_HOME=/home/hadoop/zookeeper-3.3.6

#hadoop
#export HADOOP_HOME=/home/hadoop/hadoop-2.6.5
#export HADOOP_HOME=/home/hadoop/hadoop-3.0.0
export HADOOP_HOME=/home/hadoop/hadoop-2.8.3
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib:$HADOOP_COMMON_LIB_NATIVE_DIR"
#export HADOOP_COMMON_HOME=$HADOOP_HOME/share/hadoop/common
#export HADOOP_HDFS_HOME=$HADOOP_HOME/share/hadoop/hdfs
#export HADOOP_MAPRED_HOME=$HADOOP_HOME/share/hadoop/mapreduce
#export HADOOP_YARN_HOME=$HADOOP_HOME/share/hadoop/yarn
#export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

#hive
export HIVE_CONF=/home/hadoop/apache-hive-1.2.2-bin/conf
export HIVE_HOME=/home/hadoop/apache-hive-1.2.2-bin
export HCAT_HOME=$HIVE_HOME/hcatalog
export hive_dependency=$HIVE_HOME/conf:$HIVE_HOME/lib/*:$HCAT_HOME/share/hcatalog/hive-hcatalog-core-1.2.2.jar

#hbase
export HBASE_HOME=/home/hadoop/hbase-1.2.6

#kylin
export KYLIN_HOME=/home/hadoop/apache-kylin-2.2.0-bin


#jdk
export JAVA_HOME=/usr/jdk64/jdk1.8.0_40
#classpath
export CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$ZOOKEEPER_HOME/lib:$HIVE_HOME/lib:$HBASE_HOME/lib:$KYLIN_HOME/lib:~/download_lib"

#path
PATH=/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:$HOME/bin
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$HBASE_HOME/bin:$ZOOKEEPER_HOME/bin:$KYLIN_HOME/bin:$PATH
