#!/bin/bash

FILEPATH="$@"

if [[ -f $FILEPATH ]]
then
	echo "FIle exist"
else 
	echo "Create file now"
	touch $FILEPATH
fi
