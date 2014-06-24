#!/usr/bin/env bash     
#title           :playback.sh
#description     :Plays a video
#author          :bullshit <me@oskarholowaty.com>
#date            :20140524
#version         :0.1 
#usage           :./playback.sh
#notes           :
#bash_version    :4.2.37
#==============================================================================
# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

source /opt/play-movie/global.sh

SERVICE='omxplayer'

# now for our infinite loop!
while true; do
	if ps ax | grep -v grep | grep $SERVICE > /dev/null
	then
		log "playback" "running"
		if [ -f "${DOWNLOAD_PATH}/new_file" ]; then
			rm -f "${DOWNLOAD_PATH}/new_file"
			log "playback" "new file downloaded"
		fi
		sleep 1;
	else
		if [ -f "${DOWNLOAD_PATH}/${VIDEO_FILENAME}" ]; then
			omxplayer $OMX_PLAYER_ARGS "${DOWNLOAD_PATH}/${VIDEO_FILENAME}" > /dev/null
		else
			log "playback" "video not avaiable"
			#omxplayer $OMX_PLAYER_ARGS "${SCRIPT_PATH}/na.mp4" > /dev/null
		fi
	fi
done