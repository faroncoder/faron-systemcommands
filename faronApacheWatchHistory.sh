#! /bin/bash
faronstats="/home/faron/bin/logs/statshistory.log"
#This is to read logs and grab unauthorized ip robot snooping on faron server
#and then insert to iptable for blocking

## Insert date of cron job
echo "------START" >> $faronstats
date +%D >> $faronstats
echo "faron history:: access ::" >> $faronstats
cat /home/faron/bin/logs/access/* | awk '{print$1}' | sort | uniq -c  >> $faronstats
exit 0
