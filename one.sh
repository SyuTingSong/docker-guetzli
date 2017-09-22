#!/bin/sh

f=$1

echo Start convert $f
guetzli ${@:2} --quality $QUALITY "$f" "output/$f"
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

