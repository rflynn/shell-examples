#!/bin/bash
# vim: set ts=4 et:

<<zimbatm
Better than set -e is trapping ERR. You can set up a trap that prints out
the command that failed, and the line it's on, rather than just dying
quietly like set -e does. It's much easier to debug that than trying to
work ahead from the last command with output. For bonus points, when you
have a bunch of scripts together, put the trap code in its own file and
source it in all the other scripts (rather than duplicating code).
zimbatm
# ref: https://news.ycombinator.com/item?id=8054440

set -o errtrace
trap 'err_handler $?' ERR

err_handler() {
    trap - ERR
    let i=0 exit_status=$1
    echo "Aborting on error $exit_status:"
    echo "--------------------"
    while caller $i; do ((i++)); done
    exit $?
}

ls doesnotexist # do something that errors out

