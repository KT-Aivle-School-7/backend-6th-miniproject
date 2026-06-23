#!/bin/bash
cd /home/ec2-user/app
nohup java -jar app.jar > /home/ec2-user/app/server.log 2>&1 &
echo "Server started"