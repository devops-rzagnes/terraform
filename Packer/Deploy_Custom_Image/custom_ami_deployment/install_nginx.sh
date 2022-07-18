#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install -y nginx1
sudo systemctl enable nginx
sudo systemctl start nginx
sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock