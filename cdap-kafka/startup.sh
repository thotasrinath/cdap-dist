#!/bin/bash

ls /opt/cdap/kafka
ls /opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/lib/

echo "Starting Cdap Kafka"
/opt/cdap/kafka/bin/cdap kafka-server start

echo "logging"
ls /var/log/cdap/
tail -1000f /var/log/cdap/kafka-server--*.log