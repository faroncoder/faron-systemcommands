#!/bin/bash
FILE=""


# init
# look for empty dir 
if [ "$(ls -A)" ]; then
#	echo "Take action $DIR is not Empty"
	FILE=$(find ./ -type f ! -path "./done/*" ! -path "./bye/*" | sort | head -1)
#	echo $FILE	
#FILE="$(find . -type f ! -path "./*" | sort | head -1)"
#	FILE="$(find . -type f -name "*.mp4" ! -path "./mp4/*" | sort | head -1)"
#	NEWNAME= echo "$FILE" | cut -d'.' --complement -f2-
#	echo $NEWNAME
	#echo $NEWNAME
	#OUTFILE="$(echo "$FILE" | cut -d'.' --complement -f2-)"
	#ENDFILE="$OUTFILE.mkv"
#	ffmpeg -i "$FILE" -c:v libx264 -preset medium -crf 20 -c:a libfaac mkv/"$FILE.mkv" < /dev/null
	#ffmpeg -i  -y -c:v libx264 -preset medium -crf 20 -movflags +faststart -c:a libfdk_aac "$FILE.mp4" < /dev/null

	ffmpeg -y -i "$FILE" -c:v libx264 -s 640x360 -preset medium -b:v 555k -pass 1 -an -f mp4 /dev/null && \
ffmpeg -i input -c:v libx264 -preset medium -b:v 555k -pass 2 -c:a libfdk_aac -b:a 128k done/"$FILE.mp4"



	#	ffmpeg -i mkv/"$FILE.mkv" -c:v libx264 -preset medium -crf 20 -movflags +faststart -c:a libfaac mkv/mp4/"$FILE.mp4" < /dev/null

	#ffmpeg -i  mp4/"$FILE.mp4" -c:v libvpx -preset slow -crf 20 -movflags +faststart -c:a libvorbis webm/"$FILE.webm" < /dev/null 

### GUIDE FOR LIVE STREAMING: avoid the -sameq flag, which means "same quantizer" not same quality, and probably should be avoided.

### SETTING THAT WORKS FOR LIVE STREAMING: 
###
### METHOD 1: 
### ffmpeg -y -loglevel warning -f dshow -i video="screen-capture-recorder" -vf crop=690:388:136:0 -r 30 -s 962x388 -threads 2 -vcodec libx264 -vpre baseline -vpre my_ffpreset -f flv rtmp:///live/myStream.sdp
### 
### Here is my FFmpeg preset (libx264-my_ffpreset.ffpreset):
### coder=1
### flags2=+wpred+dct8x8
### level=31
### maxrate=1200000
### bufsize=200000
### wpredp=0
### g=60
### refs=1
### subq=3
### trellis=0
### bf=0
### rc_lookahead=0
###
### METHOD 2:
###
### ffmpeg -f dshow -i video="Virtual-Camera" -vcodec libx264 -tune zerolatency -b 900k -f mpegts udp://10.1.0.102:1234
### 
### METHOD 3:
### 
### ffmpeg -f dshow -i video="screen-capture-recorder":audio="Stereo Mix (IDT High Definition" -vcodec  libx264 -preset ultrafast -tune zerolatency -r 10 -async 1 -acodec libmp3lame -ab 24k -ar 22050 -bsf:v h264_mp4toannexb -maxrate 750k -bufsize 3000k   -f mpegts udp://192.168.5.215:48550
### 
### 
### Here is how you stream to twitch.tv or similar services (rtmp protocol), using ffmpeg 1.0 or ffmpeg-git (tested on 2012-11-12), this is also for pulseaudio users: Example 1, no sound:

### ffmpeg -f x11grab -s 1920x1200 -r 15 -i :0.0 -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -threads 0 -f flv "rtmp://live.twitch.tv/app/live_********_******************************"
### 
### Example 2, first screen (on dual screen setup, or if on a single screen):
### ffmpeg -f x11grab -s 1920x1200 -r 15 -i :0.0 -f pulse -ac 2 -i default -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -c:a libmp3lame -ab 96k -ar 22050 -threads 0 -f flv "rtmp://live.twitch.tv/app/live_********_******************************"
### 
### Example 3, second screen (on dual screen setup):
### ffmpeg -f x11grab -s 1920x1200 -r 15 -i :0.0+1920,0 -f pulse -ac 2 -i default -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -c:a libmp3lame -ab 96k -ar 22050 -threads 0 -f flv "rtmp://live.twitch.tv/app/live_********_******************************"

### FOR MORE SPECIFICATION USAGE: https://sites.google.com/site/linuxencoding/x264-ffmpeg-mapping







### 
### FFmpeg can stream a single stream using the ​RTP protocol. In order to avoid buffering problems on the other hand, the streaming should be done through the -re option, which means that the stream will be streamed in real-time (i.e. it slows it down to simulate a live streaming source.
### 
### For example the following command will generate a signal, and will stream it to the port 1234 on localhost:
### 
###  ffmpeg -re -f lavfi -i aevalsrc="sin(400*2*PI*t)" -ar 8000 -f mulaw -f rtp rtp://127.0.0.1:1234
### To play the stream with ffplay, run the command:
### 
### ffplay rtp://127.0.0.1:1234
### 
### 
## -pix_fmt yuv420p    ## code for dumb player --> should be included in faron's standard wraps.

### Ffmpeg can also receive from "a source" (for instance live or udp) and then transcode and re-broadcast the stream.
### 
### The command line I use to pull the stream from port 5000, transcode it, and push it is: ffmpeg -i 'udp://localhost:5000?fifo_size=1000000&overrun_nonfatal=1' -crf 30 -preset ultrafast -acodec aac -strict experimental -ar 44100 -ac 2 -b:a 96k -vcodec libx264 -r 25 -b:v 500k -f flv 'rtmp://<wowza server IP>/live/cam0'
### 
### -i 'udp://localhost:5000?fifo_size=1000000&overrun_nonfatal=1' tells ffmpeg where to pull the input stream from. The parts after the ? are probably not needed most of the time, but I did need it after all.
### 
### -crf 30 sets the Content Rate Factor. That's an x264 argument that tries to keep reasonably consistent video quality, while varying bitrate during more 'complicated' scenes, etc. A value of 30 allows somewhat lower quality and bit rate. See [x264EncodingGuide].
### 
### !!! IMPORTANT !!! -profile:v baseline -level 3.0  | should be used in faron's standard wraps.  REASON:  videos to have highest compatibility with target devices (older iOS versions or all Android devices):
###
### !!! IMPORTANT !!!  |  -preset ultrafast | as the name implies provides for the fastest possible encoding. If some tradeoff between quality and encode speed, go for the speed. This might be needed if you are going to be transcoding multiple streams on one machine.
###
### !!! IMPORTANT !!!  | -acodec aac (sets the audio codec [internal AAC encoder]) 
### | -strict experimental (allows use of some experimental codecs [the internal AAC encoder is experimental]) 
### | -ar 44100 (set the audio sample rate) 
### | -ac 2 (specifies two channels of audio) 
### | -b:a 96k (sets  the audio bit rate) 
### | -vcodec libx264 (sets the video codec) 
### | -r 25 (set the frame rate) 
### | -b:v 500k (set the video bit  rate) 
### | ### OPTIONAL ### -f flv (says to deliver the output stream in an flv wrapper) 
### | ### OPTIONAL ### 'rtmp://<wowza server IP>/live/cam0' (is where the transcoded video stream gets pushed to)


### !!! IMPORTANT !!!
#### TO STREAM PROPERLY BETWEEN 2 SERVERS (i.e. F5 streams to F1 for webusers to connect (to F1))
##     ffmpeg -i INPUT -acodec libmp3lame -ar 11025 --f rtp rtp://host:port

##where host is the receiving IP. Then receive the stream using VLC or ffmpeg from that port (since rtp uses UDP, the receiver can start up any time).
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 
### (as a client) establish a connection do that host on that port (assuming it has a server waiting for the incoming connection). You could receive it like this:
###  ffmpeg -i tcp://local_hostname:port?listen
### (basically, one side needs to specify "listen" and the other needs to not to).
### To use with mplayer as a receiver it would be like
### ffmpeg -i ... -f mpegts "tcp://127.0.0.1:2000"
### and on the mplayer side
### mplayer ... ffmpeg://tcp://127.0.0.1:2000?listen
### (start mplayer first)
### Another option is to use rtp (which by default uses udp) but by specifying it use tcp:
### ffmpeg -i input -f rtsp -rtsp_transport tcp rtsp://localhost:8888/live.sdp lists the option
### Then you may receive it like this (ffplay or ffmpeg):
### ffplay -rtsp_flags listen rtsp://localhost:8888/live.sdp?tcp # ending ?tcp may not be needed -- you will need to start the server up first, before the sending client
### ffmpeg also has a "listen" option for rtmp so it may be able to receive a "straight" rtmp streams from a single client that way.
### With tcp based streams you can probably use any formatting/muxer, but with udp you need to be careful and use a muxer that supports 'connecting anytime' like mpegts.
### If you are forced to use udp (for instance you need to broadcast to a multicast port for whatever reason) then you may be able to avoid the packet loss by (sending less data or sending the same frames over and over again so they have a higher chance of being received).
###  SOURCE: https://trac.ffmpeg.org/wiki/StreamingGuide
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### 


#	ffmpeg -i  "$FILE" -ss 0 -t 600 -c:v libvpx -preset slow -crf 19 -s 640x360 -movflags +faststart -c:a libvorbis spilt7.webm

#	mv $FILE /del
	mv "$FILE" bye/
	#mv /home/faron/bin/uploads/$FILE /home/faron/bin/uploads/del

./fireffmpeg.sh

else
    echo "No file to convert."
fi
exit 0
