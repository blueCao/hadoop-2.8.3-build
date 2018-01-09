## 集群示例
```
192.168.0.67   master   #主节点
192.168.0.22   slave1   #从节点1
192.168.0.23   slave2   #从节点2
192.168.0.24   slave3   #从节点3
```

## 1.环境准备
- #### hosts文件新增地址解析
> 在所有节点上将/etc/hosts添加如下配置
```
192.168.0.67   master
192.168.0.22   slave1
192.168.0.23   slave2
192.168.0.24   slave3
```

- #### 创建新用户 hadoop
>在所有节点上执行
```
#切换到root用户（用户创建角色的权限）
su root

#新建用户
useradd hadoop

#重置新用户密码
passwd hadoop

#切换为 hadoop 用户（以下所有命令均以hadoop用户的身份执行）
su - hadoop  #输入刚才重置的用户密码
```

- #### 配置免密码登录
> 在所有节点上执行
```
# 生成rsa密钥对
ssh-key-gen -t rsa  #输入回车确认

# 赋予这个节点免密码远程登录所有节点权限
ssh-copy-id -i ~/.id_rsa.pub master #需要输入密码
ssh-copy-id -i ~/.id_rsa.pub slave1 #需要输入密码
ssh-copy-id -i ~/.id_rsa.pub slave2 #需要输入密码
ssh-copy-id -i ~/.id_rsa.pub slave3 #需要输入密码
```
- #### 下载Java、Hadoop
> 在所有节点上执行
```
# 用户hadoop，下载到它所在的home目录
cd ~
# 使用同一个版本的jdk1.8.0_151
wget http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz?AuthParam=1512959705_e4dc29c2aab1553d18025f1c40716508
# 需要超级权限
su root
mkdir -p /usr/jdk64
cd /usr/jdk64
# 解压到这个目录到/usr/jdk44
tar -xvzf ~/jdk-8u151-linux-x64.tar.gz
exit

cd ~
# 下载hadoop-2.8.3
wget http://mirrors.shuosc.org/apache/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz

# 解压上述包到home目录
tar -xvzf hadoop-2.8.3.tar.gz
```

- #### 配置新增系统变量
> 在所有节点上/home/hadoop/.bash_profile文件添加如下配置
```
#hadoop
export HADOOP_HOME=/home/hadoop/hadoop-2.8.3
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib:$HADOOP_COMMON_LIB_NATIVE_DIR"

#jdk
export JAVA_HOME=/usr/jdk64/jdk1.8.0_40
#classpath
export CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/jre/lib"

#path
PATH=/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:$HOME/bin
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```

- #### 修改配置文件
> 将系统的配置文件替换成github中配置好的配置文件
```
#切换到hadoop用户主目录
mkdir -p download
cd download
#下载示例代码
git clone https://github.com/blueCao/hadoop-2.8.3-build.git

#将hadoop2.6.3/etc/hadoop 替换成 github中的示例配置
cp hadoop2.6.3/etc/hadoop/*  $HADOOP_HOME/etc/hadoop
```
- #### 将新的配置文件拷贝到其他节点
> 在将master的所有配置拷贝到其他节点
```
scp  $HADOOP_HOME/etc/hadoop/* slave1:$HADOOP_HOME/etc/hadoop
scp  $HADOOP_HOME/etc/hadoop/* slave2:$HADOOP_HOME/etc/hadoop
scp  $HADOOP_HOME/etc/hadoop/* slave3:$HADOOP_HOME/etc/hadoop
```

## 2.启动hadoop集群
- 在master节点上启动hadoop集群
```
#将工作目录切换到git下载的目录
cd download/hadoop-2.8.3-build

#创建hadoop目录、格式化namende
sh hadoop-format.sh

#运行启动脚本
sh hadoop-start-all.sh
```
- 启动成功jps查看java进程结果如下
```
#master启动的节点java进程如下
[hadoop@master ~]$ jps
74355 JobHistoryServer
74050 ResourceManager
73561 NameNode


#slave1节点启动的java进程如下
[hadoop@slave1 sbin]$ jps
40647 NodeManager
40381 SecondaryNameNode
40126 DataNode

#slave2节点启动的java进程如下
[hadoop@slave2 ~]$ jps
39920 DataNode
40411 NodeManager

#如果没有进程缺失的情况，则表示hadoop集群启动成功
```


## 3.停止hadoop集群
- 在master节点上停止hadoop集群
```
#将工作目录切换到git下载的目录
cd download/hadoop-2.8.3-build

#运行停止脚本
sh hadoop-stop-all.sh
```
- 停止成功jps查看java进程以上进程将不存在
```
[hadoop@slave2 ~]$ jps

#如果没有hadoop java进程，则表示hadoop集成功关闭
```

## 4.清理hadoop占用的文件和目录
- 在master上运行
```
# 删除所有hadoop 日志、临时文件、hdfs文件，清理hadoop现场
sh hadoop-clear-all.sh
```
