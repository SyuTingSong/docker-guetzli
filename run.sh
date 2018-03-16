#!/bin/sh

SUBCMD=$1

if [ $SUBCMD = 'all' ]; then
    if [ ! -d output ]; then
        echo "Creating output dir..."
        mkdir output
    fi
    if [ ! -d original ]; then
        echo "Creating original dir..."
        mkdir original
    fi
    echo Quality: $QUALITY
    echo Compressing `ls *.jpg *.JPG *.png *.PNG |wc -l` files with $MAX_PROCS threads...
    for f in *.jpg *.JPG *.png *.PNG; do
        sem -j $MAX_PROCS "/one.sh \"$f\" ${@:3}" 2>/dev/null
    done
    sem --wait 2>/dev/null
else
    exec $@
fi

