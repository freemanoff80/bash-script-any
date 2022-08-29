#!/bin/bash

### This script will truncate the Docker containers logs if its size is larger than set
### Version 3

OPTION=$1

FILE_SIZE_MB='100'
DOCKER_LOG_FILES_ARRAY=($(du -mxa /var/lib/docker/containers/* | sort -hr | grep .*json.log | awk '$1>'$FILE_SIZE_MB'{print $NF}'))

case "$OPTION" in

	### Option List Logs
	'-l' | '--list' | 'list' )

	for DOCKER_LOG_FILE in ${DOCKER_LOG_FILES_ARRAY[*]};
		do
		
			if [ -f $DOCKER_LOG_FILE ]; then
			
				du -h ${DOCKER_LOG_FILE};
			
			fi
		
		done

	;;


	### Option Truncate Logs
	*)

	for DOCKER_LOG_FILE in ${DOCKER_LOG_FILES_ARRAY[*]};
		do
	
			if [ -f $DOCKER_LOG_FILE ]; then
			
				echo ${DOCKER_LOG_FILE};
				#truncate -s ${FILE_SIZE_MB}M $DOCKER_LOG_FILE;
			
			fi
		
		done

	;;


esac

exit 0
