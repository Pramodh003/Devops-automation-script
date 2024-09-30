#!/bin/bash

for i in {1..10}
do 
	echo $(date) | awk -F " " '{print $1 $2 $3 $4}'
	sleep 1
done
