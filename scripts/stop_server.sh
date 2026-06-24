#!/bin/bash

if [ -f /home/ubuntu/app/app.pid ]; then
    PID=$(cat /home/ubuntu/app/app.pid)
    if kill -0 $PID 2>/dev/null; then
        kill $PID
        sleep 5
    fi
    rm -f /home/ubuntu/app/app.pid
else
    PID=$(lsof -ti tcp:8080 2>/dev/null)
    if [ -n "$PID" ]; then
        kill $PID
        sleep 3
    fi
fi
exit 0