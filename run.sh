#!/bin/sh

SUBCMD=$1

if [ $SUBCMD = 'all' ]; then
    if [ ! -d output ]; then
        mkdir output
    fi
    
    fs=*.jpg
    
    for f in $fs
    do
        echo $f
        guetzli ${@:2} "$f" "output/$f"
    done
else
    exec $@
fi

