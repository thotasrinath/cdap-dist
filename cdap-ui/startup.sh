#!/bin/bash

echo "Starting Cdap UI"
/opt/cdap/ui/bin/cdap ui start

echo "logging"
ls /var/log/cdap/
tail -1000f /var/log/cdap/ui--*.log