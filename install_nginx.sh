#!/bin/bash

sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Kartheek Devops" | sudo tee /var/www/html/index.html
