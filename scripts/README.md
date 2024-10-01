#### when you need to print the variable value then you need to use double quote example
##### y=20
##### AK="akash-secops-$y"
##### echo $AK
##### output -->  akash-ops-20


#### To select last field we need to use following command
##### rev file_paths.txt | cut -d '/' -f1 | rev
