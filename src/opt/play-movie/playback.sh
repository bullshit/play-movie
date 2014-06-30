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
LOG_FILE="/var/log/playmovied.log"
SERVICE='omxplayer'
PLAYBACK_FILE="playback${VIDEO_EXT}"
# now for our infinite loop!
while true; do
	if ps ax | grep -v grep | grep $SERVICE > /dev/null
	then
		log "playback" "running"

		sleep 1;
	else
		if [ -f "${DOWNLOAD_PATH}/new_file" ]; then
			log "playback" "new file downloaded"
			f=`cat "${DOWNLOAD_PATH}/new_file"`

			log "playback" "move new file to standard playback filename"
			mv "${DOWNLOAD_PATH}/${f}" "${DOWNLOAD_PATH}/${PLAYBACK_FILE}"
			rm -f "${DOWNLOAD_PATH}/new_file"
			
		fi
		if [ -f "${DOWNLOAD_PATH}/${PLAYBACK_FILE}" ]; then
			omxplayer $OMX_PLAYER_ARGS "${DOWNLOAD_PATH}/${PLAYBACK_FILE}" > /dev/null
		else
			log "playback" "video not available"
			#omxplayer $OMX_PLAYER_ARGS "${SCRIPT_PATH}/na.mp4" > /dev/null
		fi
	fi
done