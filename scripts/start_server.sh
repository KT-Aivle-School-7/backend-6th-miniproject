#!/bin/bash

APP_DIR=/home/ubuntu/app
# 💡 만약 경로가 뒤틀렸을 때를 대비해 전체 디렉토리에서 app.jar를 검색하도록 설정
JAR_FILE=$(find $APP_DIR -name "app.jar" | head -1)
LOG_FILE=$APP_DIR/app.log

# 🚨 디버깅을 위한 핵심 장치: 파일이 없다면 현재 폴더 구조를 로그에 전부 찍어라!
if [ -z "$JAR_FILE" ] || [ ! -f "$JAR_FILE" ]; then
    echo "❌ 에러: app.jar 파일을 찾을 수 없습니다."
    echo "========= 현재 배포된 전체 파일 목록 (디버깅용) ========="
    ls -R $APP_DIR
    echo "========================================================"
    exit 1
fi

touch $LOG_FILE
chmod 666 $LOG_FILE

nohup java -jar $JAR_FILE > $LOG_FILE 2>&1 &

APP_PID=$!
echo $APP_PID > $APP_DIR/app.pid
echo "Started with PID $APP_PID (JAR: $JAR_FILE)"

sleep 10
if kill -0 $APP_PID 2>/dev/null; then
    echo "App is running successfully!"
    exit 0
else
    echo "App failed to start."
    tail -20 $LOG_FILE
    exit 1
fi