#!/bin/sh
#title           :global.sh
#description     :load configuraton
#author          :bullshit <me@oskarholowaty.com>
#date            :20140524
#version         :0.1  
#usage           :./global.sh
#notes           :
#bash_version    :4.2.37
#==============================================================================

SCRIPT_PATH=`pwd`
DOWNLOAD_PATH="/tmp"

VIDEO_URL="http://62.99.159.212/oldpage/alt.mov"
VIDEO_EXT=".mov"
VIDEO_FILENAME="alt${VIDEO_EXT}"

LOG_FILE="${DOWNLOAD_PATH}/cronjob.log"


if [ -f /etc/default/play-movie ]; then
	source /etc/default/play-movie
	mkdir -p $DOWNLOAD_PATH >& /dev/null
fi

#
# functions
#
log() {
        d=`date +"%b %d %H:%M:%S"`
        echo "$d $1" >> $LOG_FILE
}
