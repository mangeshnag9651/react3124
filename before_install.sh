#!/bin/bash
cd /var/www/html
sudo rm -rf *
# cd ~

#USER INPUT BRANCH
# Download the ZIP file from S3
# aws s3 cp s3://deployment3434/react-build.zip /home/ubuntu
 
# Extract the ZIP file
# sudo unzip -o react-build.zip -d /var/www/html
# sudo unzip -o /home/ubuntu/react-build.zip -d /var/www/html
 
# Cleanup: remove the downloaded ZIP file if needed
# rm /path/to/empty/folder/your-zip-file.zip
