#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# install nginx
yum update
amazon-linux-extras install nginx1 -y

# make sure nginx is started
systemctl start nginx.service
systemctl enable nginx.service
