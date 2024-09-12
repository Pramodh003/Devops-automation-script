#!/bin/bash
echo "Check disk utilization in server"
disk_size=$(df -h | grep -i /dev/xvda16 | awk '{print $5}' | cut -d "%" -f1)
echo "$disk_size%"
if  [  $disk_size -eq 17 ];  then
        echo "Enough disk is not available"
else
        echo "Enough disk is available"
fi