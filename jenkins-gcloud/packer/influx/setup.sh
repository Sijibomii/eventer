#!/bin/bash

echo "Install influxdb"
yum install influxdb
systemctl start influxdb

