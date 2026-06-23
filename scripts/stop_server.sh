#!/bin/bash

echo "=== [stop_server.sh] 서버 종료 시작: $(date) ==="

# PID 파일로 프로세스 종료 시도
if [ -f /home/ec2-user/app/app.pid ]; then
    PID=$(cat /home/ec2-user/app/app.pid)

    if kill -0 $PID 2>/dev/null; then
        echo "PID $PID 프로세스 종료 중..."
        kill $PID
        sleep 5

        # 아직 살아있으면 강제 종료
        if kill -0 $PID 2>/dev/null; then
            echo "강제 종료(kill -9) 시도..."
            kill -9 $PID
        fi
    else
        echo "PID $PID 프로세스가 이미 종료되어 있습니다."
    fi

    rm -f /home/ec2-user/app/app.pid
else
    echo "PID 파일 없음. 포트 8080으로 프로세스 검색 중..."

    PID=$(lsof -ti tcp:8080 2>/dev/null)
    if [ -n "$PID" ]; then
        echo "포트 8080 사용 중인 PID $PID 종료 중..."
        kill $PID
        sleep 3
    else
        echo "8080 포트를 사용 중인 프로세스 없음. 넘어갑니다."
    fi
fi

echo "=== [stop_server.sh] 완료 ==="
