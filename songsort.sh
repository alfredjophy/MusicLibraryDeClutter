#!/bin/bash

inputDirectory=$1

for filename in $inputDirectory/*.mp3; do
	songTitle=$(songrec audio-file-to-recognized-song "$filename"|python3 ~/Project/SongSorter/jsonParser.py )
	echo $songTitle
	dirName=${songTitle// /_}
	dirName=${dirName//(}
	dirName=${dirName//)}
	dirName=${dirName//\"}
	dirName=${dirName//./_}
	if [ ! -d "${dirName}" ]; then
		mkdir "${dirName}"
		echo "$songTitle" >> "$dirName"/songName.txt
	fi
	newfilename=${filename// /_}
	mv "$filename" "$newfilename"
	mv "$newfilename" "${dirName}"
done

for subDir in "$inputDirectory"/*/
	do
	largestFile=$(find "$subDir" -type f -exec ls -al {} \; | sort -nr -k5 | head -n 1|awk '{print $9}')
	echo $largestFile
	
	filename=$(cat "$inputDirectory"/"$subDir"/songName.txt)
	echo $filename
	mv "$largestFile" "$inputDirectory/$filename.mp3"
	rm -rf "$subDir"
done
