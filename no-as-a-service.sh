#!/bin/sh
# "NO" as a service
# curl http://localhost:6969/
while [ 1 ]
do
    echo "HTTP/1.1 200 OK\r\n\r\n" | nc -l 7879;
    say -v Alex no &
done
