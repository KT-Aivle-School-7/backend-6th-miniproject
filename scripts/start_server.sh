#!/bin/bash

cd /home/ec2-user/app
# CodeDeploy가 파일을 복사해둔 경로로 이동
# appspec.yml의 destination과 일치해야 함

JAR_FILE=$(ls build/libs/*.jar | grep -v plain | head -1)
# ls build/libs/*.jar     → build/libs 폴더의 모든 jar 파일 목록 조회
# grep -v plain           → 이름에 "plain" 이 포함된 파일 제외
#                           (Gradle은 두 가지 jar를 만들기 때문)
#   bookapp-0.0.1-SNAPSHOT.jar        ← 실행 가능한 jar (이걸 써야 함)
#   bookapp-0.0.1-SNAPSHOT-plain.jar  ← 실행 불가능한 jar (제외)
# head -1                 → 여러 개 나와도 첫 번째 하나만 선택
# $()                     → 명령어 실행 결과를 변수에 저장

nohup java -jar $JAR_FILE > /home/ec2-user/app/server.log 2>&1 &
# java -jar $JAR_FILE     → Spring Boot jar 실행
# nohup ... &             → 백그라운드에서 실행 (SSH 끊겨도 계속 실행됨)
# > server.log            → 출력 로그를 server.log 파일에 저장
# 2>&1                    → 에러 로그도 같은 파일에 저장

echo "Server started: $JAR_FILE"
# 어떤 jar가 실행됐는지 로그에 출력