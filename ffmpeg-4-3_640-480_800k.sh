#!/bin/bash
mkdir lib
mkdir bye
file=$(find ./ -maxdepth 1 -type f ! -name 'ffmpeg*' ! -name 'bye' ! -name 'lib' | sort | head -1)
ffuid=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
ffcomp="$ffuid.mp4"
ffbye="bye/"
if [ "$(ls -A)" ]; then
## ACTION IF MEDIA FILE IS PRESENTED IN DIRECTORY
	#2 PASSES ENCOIDNG ## TRIM TO 640X480 | PRESENT MEDIUM | X264 | AAC ###
ffmpeg -i "$file" -y -c:v libx264 -s 640x480 -b:v 800k -preset medium -movflags +faststart -pass 1 -an -f mp4 "lib/out.mp4" < /dev/null && ffmpeg -i "$file" -y -c:v libx264 -s 640x480 -b:v 800k -preset medium -movflags +faststart -pass 2 -c:a libfdk_aac -b:a 128k -metadata title="" -metadata artist="" "lib/$ffcomp" < /dev/null
mv "$file" "$ffbye"
#rm  "$ffile"
     else
		echo "no files to covert & cleaning up"
		#rm -r ffmpeg2*
		#echo "packing old videos for disposal"
		#tar -zcvf "$fftar.tar.gz" bye/
		# rm -r bye
		# echo "orginial copies disposed & tar.gz created"
		exit 0
fi
./ffmpeg-4-3_640-480_800k.sh
exit 0
