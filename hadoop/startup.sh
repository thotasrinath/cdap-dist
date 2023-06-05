#!/bin/bash

echo "Fomat Namenode"
$HADOOP_HOME/bin/hadoop namenode -format

service ssh start
ssh-keygen -m PEM -t rsa -b 2048 -P '' -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo "Start Zookeeper"
#$ZOOKEEPER_HOME/bin/zkServer.sh start

whereis java
echo "Start Hadoop"
$HADOOP_HOME/sbin/start-all.sh
echo "Start Hbase"
$HBASE_HOME/bin/hbase-daemon.sh --config $HBASE_HOME/conf start master
$HBASE_HOME/bin/hbase-daemon.sh --config $HBASE_HOME/conf start regionserver

tail -f /opt/hadoop/hadoop-2.9.2/logs/yarn--resourcemanager-*.log

