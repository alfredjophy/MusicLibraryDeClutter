#!/bin/bash

inputDirectory=$1

for filename in $inputDirectory/*.mp3; do
	songTitle=$(songrec audio-file-to-recognized-song "$filename"|python3 ./jsonParser.py )
	echo $songTitle
	if [ ! -d "$inputDirectory/$songTitle" ]; then
		mkdir "$inputDirectory/$songTitle"
	fi
	echo $filename
	cp "$filename" "$inputDirectory/$songTitle/"
done
