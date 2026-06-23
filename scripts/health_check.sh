#!/bin/bash

echo "=== [health_check.sh] 헬스 체크 시작: $(date) ==="

RETRY=12       # 최대 재시도 횟수
INTERVAL=5     # 재시도 간격(초)

for i in $(seq 1 $RETRY); do
    # 1순위: /actuator/health 엔드포인트
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/actuator/health 2>/dev/null)

    if [ "$HTTP_STATUS" = "200" ]; then
        echo "헬스 체크 성공 (actuator/health 200) - ${i}번째 시도"
        exit 0
    fi

    # 2순위: /api/books 로 기본 응답 확인 (actuator 없는 경우)
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/books 2>/dev/null)
    if [ "$HTTP_STATUS" = "200" ]; then
        echo "헬스 체크 성공 (/api/books 200) - ${i}번째 시도"
        exit 0
    fi

    echo "  [${i}/${RETRY}] 아직 응답 없음 (status: $HTTP_STATUS). ${INTERVAL}초 후 재시도..."
    sleep $INTERVAL
done

echo "ERROR: 헬스 체크 실패 - 앱이 응답하지 않습니다."
echo "최근 로그:"
tail -20 /home/ec2-user/app/app.log
exit 1
