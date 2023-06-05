FROM openjdk:8-jdk 
WORKDIR /

COPY cdap-gateway-6.9.0.tar.gz /home/
RUN tar -xvzf /home/cdap-gateway-6.9.0.tar.gz && \ 
    mkdir -p /opt/cdap/gateway && \
    cp -r cdap-cdap-gateway-6.9.0/* /opt/cdap/gateway/ && \
    cp /opt/cdap/gateway/VERSION /opt/cdap/

RUN apt-get update && \
    apt-get -y install libxml2-utils && \
    apt-get upgrade -y


RUN mkdir -p /opt/spark && \
    mkdir -p /opt/hadoop && \
    curl -L -o /opt/hadoop/hadoop-2.9.2.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz && \
    curl -L -o /opt/spark/spark-3.1.1-bin-without-hadoop.tgz https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-without-hadoop.tgz && \
    tar -xzf /opt/hadoop/hadoop-2.9.2.tar.gz -C /opt/hadoop && \
    curl -L -o /opt/hadoop/hadoop-2.9.2/share/hadoop/common/lib/hadoop-aws-2.9.2.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.9.2/hadoop-aws-2.9.2.jar && \
    curl -L -o /opt/hadoop/hadoop-2.9.2/share/hadoop/common/lib/aws-java-sdk-bundle-1.11.199.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.199/aws-java-sdk-bundle-1.11.199.jar && \
    tar -xzf /opt/spark/spark-3.1.1-bin-without-hadoop.tgz -C /opt/spark && \
    find /opt/hadoop -name 'paranamer-2.3.jar' -exec rm {} +

COPY cdap-site.xml /etc/cdap/conf/cdap-site.xml


ENV CLASSPATH=/etc/cdap/conf:/etc/cdap/security:/etc/hadoop/conf
ENV HADOOP_HOME=/opt/hadoop/hadoop-2.9.2
ENV SPARK_HOME=/opt/spark/spark-3.1.1-bin-without-hadoop
ENV SPARK_COMPAT=spark3_2.12
ENV HBASE_VERSION=1.2
COPY startup.sh startup.sh

EXPOSE 11015

RUN groupadd -g 1000 cdap
RUN useradd -m -u 1000 -g 1000 cdap
RUN mkdir /data
RUN chown 1000:1000 /data
RUN chmod 766 /data
RUN chmod +x /opt/cdap/gateway/bin/*
RUN chmod +x startup.sh
ENTRYPOINT [ "./startup.sh" ]
# CMD ["ls","/var/log/cdap/"]