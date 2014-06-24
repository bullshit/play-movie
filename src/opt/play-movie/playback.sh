#!/bin/bash -       
#title           :playback.sh
#description     :Plays a video
#author          :bullshit <me@oskarholowaty.com>
#date            :20140524
#version         :0.1 
#usage           :./playback.sh
#notes           :
#bash_version    :4.2.37
#==============================================================================

source ./global.sh

while true; do
	omxplayer "$OMX_PLAYER_ARGS" "${DOWNLOAD_PATH}/${VIDEO_FILENAME}"
done