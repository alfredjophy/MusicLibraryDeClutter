inputDir=$1

for subDir in "$inputDir"/*/
	do
	largestFile=$(find "$subDir" -type f -exec ls -al {} \; | sort -nr -k5 | head -n 1|awk '{print $9}')
	echo $largestFile
	
	filename=$(cat "$subDir"/songName.txt)
	echo $filename
	mv "$largestFile" "$inputDir/$filename.mp3"
	rm -rf "$subDir"
	done

		 
