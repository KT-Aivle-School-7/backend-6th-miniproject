#!/bin/bash

echo "=== [start_server.sh] 서버 시작: $(date) ==="

APP_DIR=/home/ec2-user/app
JAR_FILE=$APP_DIR/app.jar
LOG_FILE=$APP_DIR/app.log

# 앱 디렉토리 확인
if [ ! -f $JAR_FILE ]; then
    echo "ERROR: $JAR_FILE 이 존재하지 않습니다."
    exit 1
fi

# Java 설치 확인
if ! command -v java &> /dev/null; then
    echo "ERROR: Java가 설치되어 있지 않습니다."
    exit 1
fi

echo "Java 버전: $(java -version 2>&1 | head -1)"
echo "JAR 파일: $(ls -lh $JAR_FILE)"

# 백그라운드 실행 (nohup으로 세션 종료 후에도 유지)
nohup java -jar $JAR_FILE \
    --spring.profiles.active=prod \
    > $LOG_FILE 2>&1 &

# PID 저장
APP_PID=$!
echo $APP_PID > $APP_DIR/app.pid
echo "앱 시작됨. PID: $APP_PID"

# 시작 대기 (최대 60초)
echo "앱 기동 확인 중..."
for i in $(seq 1 12); do
    sleep 5
    if kill -0 $APP_PID 2>/dev/null; then
        echo "  [$((i*5))초] 프로세스 실행 중..."
    else
        echo "ERROR: 프로세스가 비정상 종료되었습니다. 로그 확인:"
        tail -30 $LOG_FILE
        exit 1
    fi

    # 포트 8080 응답 확인
    if curl -sf http://localhost:8080/actuator/health > /dev/null 2>&1; then
        echo "앱이 정상적으로 기동되었습니다! (${i}번째 확인)"
        exit 0
    fi
done

# actuator 없을 경우 포트만 확인
if lsof -i tcp:8080 > /dev/null 2>&1; then
    echo "포트 8080 응답 확인 완료. 앱 기동 성공."
    exit 0
fi

echo "WARNING: 앱이 60초 내에 응답하지 않았습니다. 로그:"
tail -30 $LOG_FILE
exit 1
