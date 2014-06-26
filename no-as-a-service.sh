#!/bin/sh
# "NO" as a service
# curl http://localhost:7879/
while [ 1 ]
do
    path=$(echo "HTTP/1.1 200 OK\r\n\r\n" | nc -l 7879 | head -n 1 | cut -f2 -d' ')
    case "$path" in
      "/yes") say=yes ;;
      "/mo") say=mo ;;
      "/yo") say=yo ;;
      "/shit") say=shit ;;
      "/schnitzel") say=schnitzel ;;
      "/twix") say=twix ;;
      "/igor") say="Igor Belyayev" ;;
      "/favicon.ico") say=skip ;;
      *) say=no ;;
    esac;
    [[ "$say" != "skip" ]] && say -v Alex "$say" &
done
