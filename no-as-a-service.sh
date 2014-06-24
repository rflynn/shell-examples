#!/bin/sh
# "NO" as a service
# curl http://localhost:6969/
while [ 1 ]
do
    nc -w 0 -l 6969;
    vol=$(osascript -e 'output volume of (get volume settings)');
    osascript -e "set volume output volume 100";
    say -v Alex no;
    osascript -e "set volume output volume $vol";
    sleep 0.1;
done
