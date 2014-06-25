#!/bin/bash
# "NO" as a service
# curl http://localhost:6969/
while [ 1 ]
do
    echo -e "HTTP/1.1 200 OK\r\n\r\n" | nc -l 6969
    say -v Alex no &
done
