#!/bin/bash

ls /opt/cdap/master
ls /opt/cdap/hbase-compat/cdap-cdap-hbase-compat-1.1-6.9.0/lib/

echo "Starting Cdap Master"
/opt/cdap/master/bin/cdap master start

echo "logging"
tail -1000f /var/log/cdap/master--*.log