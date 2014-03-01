#!/bin/bash
i=0
echo -n "name?"
read name
echo "$name$i" >> tmp.txt
i=$((i+1))
echo -n "name?"
read bname
echo "$bname$i" >> tmp.txt
i=$((i+1))
echo -n "name?"
read cname
echo "$cname$i" >> tmp.txt
cat tmp.txt
exit 0
