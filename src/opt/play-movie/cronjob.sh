#!/bin/bash -       
#title           :cronjob.sh
#description     :Download new video 
#author          :bullshit <me@oskarholowaty.com>
#date            :20140524
#version         :0.1    
#usage           :./cronjob.sh
#notes           :install this script as cronjob
#bash_version    :4.2.37
#==============================================================================

# Script path withou slash
source ./global.sh

#
# let's do it
#

# check if cronjob is downloading
if [[ -f "${SCRIPT_PATH}/block_cronjob" ]]; then
	log "last cronjob doesn't finished, maybe because its downloading a huge file"
	log "otherwise please remove the $SCRIPT_PATH/block_cronjob file "
	exit 0
fi
touch "${DOWNLOAD_PATH}/block_cronjob" 2>&1 >>  $LOG_FILE
log "test with wget if file is newer"
wget -N -P "$DOWNLOAD_PATH" -a $LOG_FILE "$VIDEO_URL"
if [ $? -eq 0 ]; then
	log "everything went fine"
fi
rm "${DOWNLOAD_PATH}/block_cronjob" 2>&1 >>  $LOG_FILE
exit 0