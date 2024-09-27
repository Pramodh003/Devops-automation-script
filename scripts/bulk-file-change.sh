#!/bin/bash
for item in /home/ubuntu/test/*.csv
do
	base_name=$(basename "$item" .csv)
	mv ${item} "/home/ubuntu/test/${base_name}.text"
done
