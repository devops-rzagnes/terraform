#! /bin/bash
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable http.service
echo "<h1>Deployed Machine via Terraform</h1>" | sudo tee /var/www/html/index.html
