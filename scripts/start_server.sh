#!/bin/bash

APP_DIR=/home/ubuntu/app
JAR_FILE=$(find $APP_DIR/build/libs -name "*-SNAPSHOT.jar" ! -name "*plain*" | head -1)
LOG_FILE=$APP_DIR/app.log

touch $LOG_FILE
chmod 666 $LOG_FILE

nohup java -jar $JAR_FILE > $LOG_FILE 2>&1 &

APP_PID=$!
echo $APP_PID > $APP_DIR/app.pid
echo "Started with PID $APP_PID"

sleep 10
if kill -0 $APP_PID 2>/dev/null; then
    echo "App is running"
    exit 0
else
    echo "App failed to start"
    tail -20 $LOG_FILE
    exit 1
fi