#!/bin/bash

inputDirectory=$1
if [[ -z $1 ]]; then
	echo "Please provide a directory"
	exit 1
fi



for filename in "$inputDirectory"/*.mp3 
	do
	
	songTitle=$(songrec audio-file-to-recognized-song "$filename"|python ~/Project/SongSorter/jsonParser.py)
	
	#resultJSON=$(songrec audio-file-to-recognized-song "$filename")
	

		
	
	
	if [[ -z $songTitle ]]; then
		if [ ! -d "Unknown^" ]; then
			mkdir "Unknown^"
		fi
		mv  "$filename" "Unknown^/"	
		
	else 
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
	fi
done

mkdir Songs

for subDir in "$inputDirectory"/*/
	do

	if [ $subDir == "./Songs/" ] || [ $subDir == "./Unknown^/" ]; then

		continue
	fi

	largestFile=$(find "$subDir" -type f -exec ls -al {} \; | sort -nr -k5 | head -n 1|awk '{print $9}')

	
	filename=$(cat "$subDir"/songName.txt)
	mv "$largestFile" "./Songs/""$filename".mp3
	rm -rf "$subDir"
done

echo "All the identified songs are in Songs directory. Unidentified ones have been moved to Unknown^"
