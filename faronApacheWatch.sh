#! /bin/bash
faronstats="/home/faron/bin/logs/stats.log"
echo "------START" >> $faronstats
date +%D >> $faronstats
echo "faron system:: access ::" >> $faronstats
cat /home/www/faron/logs/access.log | awk '{print$1}' | sort | uniq -c  >> $faronstats
#mv -R /home/www/faron/logs/access.log /home/www/faron/logs/old/
#touch /home/www/faron/logs/access.log
#echo "f5 | $ipgrab " >> $faronstats
#echo "faron system:: error" >> $faronstats
#	tail -f /home/www/faron/logs/error.log |
#		while read line; 
#		do echo "$line" >> $faronstats
#	done
#cat /home/www/faron/logs/error.log | awk '{print$1}' | sort | uniq -c >> $faronstats
#echo "faronintel system::" >> $faronstats
echo "faronintel system:: access ::" >> $faronstats
#cat /home/www/faronintel/logs/access.log | awk '{print$1}' | sort | uniq -c 
cat /home/www/faronintel/logs/access.log | awk '{print$1}' | sort | uniq -c >> $faronstats
#mv /home/www/faronintel/logs/access.log /home/www/faronintel/logs/old/
#touch /home/www/faronintel/logs/access.log
#echo "f5 | $ipgrab2 " >> $faronstats
#echo "faronintel system:: error" >> $faronstats
#	tail -f /home/www/faronintel/logs/error.log |
#		while read line; 
#		do echo "$line" >> $faronstats
#	done
#cat /home/www/faronintel/logs/error.log | awk '{print$1}' | sort | uniq -c >> $faronstats
#echo "faronhost system::" >> $faronstats
echo "faronhost system:: access ::" >> $faronstats
cat /home/www/faronhost/logs/access.log | awk '{print$1}' | sort | uniq -c  >> $faronstats
#mv /home/www/faronhost/logs/access.log /home/www/faronhost/logs/old/
#touch /home/www/faronhost/logs/access.log

#cat /home/www/faronhost/logs/access.log | awk '{print$1}' | sort | uniq -c >> $faronstats
#echo "faronhost system:: error" >> $faronstats
#	tail -f /home/www/faronhost/logs/error.log |
#		while read line; 
#		do echo "$line" >> $faronstats
#	done
#cat /home/www/faronhost/logs/error.log | awk '{print$1}' | sort | uniq -c >> $faronstats
echo "------END" >> $faronstats
mv /home/www/faronintel/logs/access.log /home/www/faronintel/logs/old/
mv /home/www/faron/logs/access.log /home/www/faron/logs/old/
mv /home/www/faronhost/logs/access.log /home/www/faronhost/logs/old/
#touch /home/www/faronintel/logs/access.log
#touch /home/www/faron/logs/access.log
#touch /home/www/faronhost/logs/access.log
exit 0
