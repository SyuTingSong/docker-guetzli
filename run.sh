#!/bin/sh

SUBCMD=$1

if [ $SUBCMD = 'all' ]; then
    if [ ! -d output ]; then
        echo "Creating output dir..."
        mkdir output
    fi
    if [ ! -d converted ]; then
        echo "Creating converted dir..."
        mkdir converted
    fi
    echo Quality: $QUALITY
    echo Compressing `ls *.jpg |wc -l` files with $MAX_PROCS threads...
    for f in *.jpg; do
        sem -j $MAX_PROCS "echo Start convert $f;\
            guetzli ${@:3} -quality $QUALITY \"$f\" \"output/$f\" ;\
            echo $f converted ; mv \"$f\" converted/"\
            2>/dev/null
    done
    sem --wait 2>/dev/null
else
    exec $@
fi

