#!/bin/bash

echo "Starting Cdap Gateway"
/opt/cdap/gateway/bin/cdap router start

echo "logging"
tail -f /var/log/cdap/router--*.log
