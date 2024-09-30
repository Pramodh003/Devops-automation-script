#!/bin/bash

read -p &quot;which site you want to check?&quot; site

ping -c 1 $site

#sleep 5s

if [[ $? -eq 0 ]]
then 
	echo &quot;Successfully connected to $site&quot;
else
	echo &quot;Unable to connect $site&quot;
fi</pre>
