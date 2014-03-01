#!/bin/bash
#echo -n "name of file to read? "
#read file
#echo -n "command to execute? (use \$line as an arg) "
#read argin
while read list.txt
		do
		 sed -e '/$HOME\/.$1/ r /home/faron/bin/commands/bashing/dirfile.dat' $line
		echo "$line ::: done" >> list.txt
		done
exit 0
