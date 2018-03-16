#!/bin/sh

f=$1
o=${f%.*}.jpg
LEN=${#f}
echo Start convert $f
guetzli ${@:$LEN} --quality $QUALITY "$f" "output/$o"
if [ $? = 0 ]; then
    echo $f converted
else
    echo $f failed
fi
mv "$f" original/

if [ "$KEEP_EXIF" = "1" -a -f "output/$o" ]; then
    exiftool -q -tagsFromFile "original/$f" "output/$o"
    rm "output/${o}_original"
fi

