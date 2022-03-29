#!/bin/bash

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install Docker engine"
yum update -y
yum install docker -y
usermod -aG docker packer
chmod 666 /var/run/docker.sock 
systemctl enable docker

#wget??
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.19.0-1.x86_64.rpm
yum localinstall -y telegraf-1.19.0-1.x86_64.rpm
systemctl enable telegraf
systemctl restart telegraf

echo "Install git"
yum install -y git
git config --global user.email "sijibomiolajubu@gmail.com"
git config --global user.name "sijibomii"