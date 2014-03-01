#!/bin/bash
dom="$1"
if [ ! $dom ]; 
	then
		echo -n  "*! Name of file ? "
		read dom
fi
cat $dom | sort | uniq | sort | tr '\n' ' ' > tmp.dat
cat tmp.dat | sort | uniq | sort | tr ' ' '\n' > $dom
rm tmp.dat
exit 0
