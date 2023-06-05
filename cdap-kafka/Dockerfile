FROM openjdk:8-jdk 
WORKDIR /

RUN mkdir -p /opt/cdap/kafka

COPY cdap-kafka-6.9.0.tar.gz /opt/cdap/kafka/cdap-kafka-6.9.0.tar.gz
RUN cd /opt/cdap/kafka && tar -xvzf cdap-kafka-6.9.0.tar.gz && \
    cp -r /opt/cdap/kafka/cdap-cdap-kafka-6.9.0/* . && \
    cp /opt/cdap/kafka/VERSION /opt/cdap/

RUN apt-get update && \
    apt-get -y install libxml2-utils vim && \
    apt-get upgrade -y


RUN mkdir -p /opt/spark && \
    mkdir -p /opt/hadoop && \
    mkdir -p /opt/cdap/kafka/ext/jdbc/postgresql && \
    curl -L -o /opt/hadoop/hadoop-2.9.2.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz && \
    curl -L -o /opt/spark/spark-3.1.1-bin-without-hadoop.tgz https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-without-hadoop.tgz && \
    curl -L -o /opt/hadoop/hbase-1.2.0-bin.tar.gz https://archive.apache.org/dist/hbase/1.2.0/hbase-1.2.0-bin.tar.gz && \
    curl -L -o /opt/cdap/kafka/ext/jdbc/postgresql/postgresql-42.2.5.jar https://jdbc.postgresql.org/download/postgresql-42.2.5.jar && \
    curl -L -o /opt/cdap/kafka/ext/jdbc/postgresql/postgres-socket-factory-1.0.12-jar-with-dependencies.jar https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory/releases/download/v1.0.12/postgres-socket-factory-1.0.12-jar-with-dependencies.jar && \
    tar -xzf /opt/hadoop/hadoop-2.9.2.tar.gz -C /opt/hadoop && \
    curl -L -o /opt/hadoop/hadoop-2.9.2/share/hadoop/common/lib/hadoop-aws-2.9.2.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.9.2/hadoop-aws-2.9.2.jar && \
    curl -L -o /opt/hadoop/hadoop-2.9.2/share/hadoop/common/lib/aws-java-sdk-bundle-1.11.199.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.199/aws-java-sdk-bundle-1.11.199.jar && \
    tar -xzf /opt/spark/spark-3.1.1-bin-without-hadoop.tgz -C /opt/spark && \
    tar -xzf /opt/hadoop/hbase-1.2.0-bin.tar.gz -C /opt/hadoop 

RUN mkdir -p /opt/zookeeper && \
    curl -L -o /opt/zookeeper/apache-zookeeper-3.7.1-bin.tar.gz https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz && \
    tar -xzf /opt/zookeeper/apache-zookeeper-3.7.1-bin.tar.gz -C /opt/zookeeper

RUN mkdir -p /opt/cdap/hbase-compat
COPY cdap-hbase-compat-1.1-6.9.0.tar.gz /opt/cdap/hbase-compat/cdap-hbase-compat-1.1-6.9.0.tar.gz
RUN cd /opt/cdap/hbase-compat && tar -xvzf cdap-hbase-compat-1.1-6.9.0.tar.gz 
RUN cp -r /opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/lib/*.jar /opt/hadoop/hbase-1.2.0/lib/ && \
    cp -r /opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/coprocessor/*.jar /opt/hadoop/hbase-1.2.0/lib/ 

COPY cdap-site.xml /etc/cdap/conf/cdap-site.xml
COPY hbase-site.xml /etc/cdap/conf/hbase-site.xml
COPY core-site.xml /etc/cdap/conf/core-site.xml
COPY yarn-site.xml /etc/cdap/conf/yarn-site.xml

# ENV CLASSPATH=$CLASSPATH:/etc/cdap/conf:/etc/cdap/security:/etc/hadoop/conf
ENV CLASSPATH=$CLASSPATH:/etc/cdap/conf:/etc/cdap/security:/opt/zookeeper/apache-zookeeper-3.7.1-bin:/opt/zookeeper/apache-zookeeper-3.7.1-bin/lib
# ENV CLASSPATH=$CLASSPATH:/opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/lib/*.jar:/opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/coprocessor/*.jar
ENV HADOOP_HOME=/opt/hadoop/hadoop-2.9.2
ENV HBASE_HOME=/opt/hadoop/hbase-1.2.0
ENV ZOOKEEPER_HOME=/opt/zookeeper/apache-zookeeper-3.7.1-bin
ENV SPARK_HOME=/opt/spark/spark-3.1.1-bin-without-hadoop
ENV SPARK_COMPAT=spark3_2.12
ENV HBASE_VERSION=1.2
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_CONF=$HADOOP_HOME/etc/hadoop
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_USER_NAME=hdfs
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HADOOP_HOME}/lib/native/
COPY startup.sh startup.sh

RUN groupadd -g 1000 hadoopsuperusergroup
RUN useradd -m -u 1000 -g 1000 yarn
RUN useradd -m -u 1001 -g 1000 hdfs
RUN useradd -m -u 1002 -g 1000 cdap
RUN mkdir /data
RUN chown 1000:1000 /data
RUN chmod 766 /data
RUN chmod +x /opt/cdap/kafka/bin/*
RUN chmod +x startup.sh
ENTRYPOINT [ "./startup.sh" ]
# CMD ["ls","/var/log/cdap/"]