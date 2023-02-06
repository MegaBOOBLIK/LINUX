#!/bin/bash
mkdir thumbs_1024
for f in *.JPG; do
convert $f -resize 1024 thumbs_1024/${f%%JPG}jpg
done

