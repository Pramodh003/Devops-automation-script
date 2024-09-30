#!/bin/bash

FILEPATH="/home/ubuntu/script/pramodg.txt"

if [[ -f $FILEPATH ]]
then
	echo "FIle exist"
else 
	echo "Create file now"
	touch $FILEPATH
fi
