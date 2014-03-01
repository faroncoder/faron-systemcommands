#!/bin/bash
no=1
#while test $no -le 100
while test $no
do
echo $no
no=`expr $no + 1`
done
exit 0
