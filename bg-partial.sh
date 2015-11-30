#!/bin/bash

set -v
set -e

(sleep 1; exit 0) &
x=$!
(sleep 1; exit 1) &

wait $x
wait $!


