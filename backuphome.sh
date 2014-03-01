#! /bin/bash
## For cron job backing up the system
./apt-check.sh
datetimer=$( cd bashing && ./date.sh )
serverloc=$( cd bashing && ./hostname.sh )
tarfile="$serverloc.$datetimer.home.tar.gz"
if [ "$serverloc" == "f1" ] 
	then
	tarhome="f5"
fi
if [ "$serverloc" == "f5" ] 
	then
	tarhome="f1"
fi
cd /
sudo tar -zcvf $tarfile --one-file-system \
	--exclude="/home/backups" \
	/home
echo "sending $tarfile to $tarhome..."
scp -r $tarfile "faron@$tarhome:~/backups"
echo "moving tape"
sudo mv $tarfile /home/backups
echo "backing up home completed and rebooting system needed"
#sudo reboot
cd ~/
exit 0
