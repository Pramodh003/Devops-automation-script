#!/bin/bash

while IFS="," read id name age
do
	echo "Id is $id"
	echo "name is $name"
	echo "Age is $age"
done < trial.csv
