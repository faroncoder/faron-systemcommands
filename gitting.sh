#!/bin/bash
dom="$1"
app="$2"
if [ -z $1 ]
	then
	echo -n "Which domain? "
	read dom
fi
if [ -z $2 ]
	then
	echo -n "Name of app? "
	read app
fi
pathdir="/home/www/$dom/html/$app"
binpull="/home/faron/bin/commands/vault/systemengine/scripting/dat"
##########################
if [ ! -d "/home/www/$dom" ]
	then
	echo "invalid domain.  exiting."
	exit 0
fi
cd $pathdir
git remote add origin git@github.com:faroncoder/$app.git
git add * && git add .
git push -u origin master
cd /home/faron/bin/commands/vault/systemengine/scripting
exit 0
