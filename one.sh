#!/bin/sh

f=$1
LEN=${#f}
echo Start convert $f
guetzli ${@:$LEN} --quality $QUALITY "$f" "output/$f"
if [ $? = 0 ]; then
    echo $f converted
else
    echo $f failed
fi
mv "$f" original/

if [ "$KEEP_EXIF" = "1" -a -f "output/$f" ]; then
    exiftool -q -tagsFromFile "original/$f" "output/$f"
    rm "output/${f}_original"
fi

