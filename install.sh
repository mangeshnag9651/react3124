#!/bin/bash

# Download the ZIP file from S3
aws s3 cp s3://deployment3434/react-build.zip /home/ubuntu

# Extract the ZIP file
sudo unzip -o /home/ubuntu/react-build.zip -d /var/www/html
