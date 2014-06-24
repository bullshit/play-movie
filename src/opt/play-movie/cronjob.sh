#!/usr/bin/env bash      
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
source /opt/play-movie/global.sh

#
# let's do it
#

# check if cronjob is downloading
if [[ -f "${SCRIPT_PATH}/block_cronjob" ]]; then
	log "cronjob" "last cronjob doesn't finished, maybe because its downloading a huge file"
	log "cronjob" "otherwise please remove the $SCRIPT_PATH/block_cronjob file "
	exit 0
fi
touch "${DOWNLOAD_PATH}/block_cronjob" 2>&1 >>  $LOG_FILE
log "cronjob" "test with wget if file is newer"


# here is the magic
#wget -N -P "$DOWNLOAD_PATH" -a $LOG_FILE "$VIDEO_URL"
TMP=`mktemp`
#wget -o $TMP --timestamping -r -P "$DOWNLOAD_PATH" "$VIDEO_URL" 2>&1
wget -N -o $TMP -P "$DOWNLOAD_PATH" -o $TMP "$VIDEO_URL"

result_en=$(cat $TMP | grep -i "not retrieving" | wc -l)
result_de=$(cat $TMP | grep -i "kein Download" | wc -l)
log "cronjob" "debug: TMP=${TMP} result_en=${result_en} result_de=${result_de}"

if [[ "$result_en" == "1" || "$result_de" == "1" ]]; then
	log "cronjob" "check successfull no file downloaded"
else
	log "cronjob" "new file downloaded"
	touch "${DOWNLOAD_PATH}/new_file"
	if [ "$SEND_MAIL" == "1" ]; then
		/opt/play-movie/sendmail.py 2>&1 >>  $LOG_FILE
		if [ $? -eq 0 ]; then 
			log "cronjob" "send mail successfull"
		else
			log "cronjob" "error in sendmail.py"
		fi
	else
		log "cronjob" "send mail feature disabled"
	fi
fi
rm "${DOWNLOAD_PATH}/block_cronjob" 2>&1 >>  $LOG_FILE
exit 0