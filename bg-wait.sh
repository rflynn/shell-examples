#!/bin/bash

# run multiple jobs that may fail in the background
# if any of them fails, propagate exit codes up

set -v
set -e

maybe()
{
    e=$(((RANDOM % 2)))
    echo "$$ $e"
    exit $e
}

maybe &
maybe &

for p in $(jobs -p)
do
    wait $p
done
