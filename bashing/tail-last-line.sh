#!/bin/bash
#cat test.txt | sed '$s/.$/,/' | sed '$s/.^/&/' | tr '\n' '+' > test1.txt 
tail test.txt | head -1 > string.txt
exit 0
