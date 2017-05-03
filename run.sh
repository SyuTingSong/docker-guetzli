#!/bin/sh

SUBCMD=$1

if [ $SUBCMD = 'all' ]; then
    if [ ! -d output ]; then
        mkdir output
    fi
    for f in *.jpg; do
        echo Start convert $f
        sem -j $MAX_PROCS "guetzli ${@:3}\
            -quality $QUALITY\
            \"$f\" \"output/$f\" ; echo $f converted"\
            2>/dev/null
    done
    sem --wait 2>/dev/null
else
    exec $@
fi

