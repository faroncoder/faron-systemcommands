#!/bin/bash
nodejs=$( grep node.js ~/.bashrc )
if [ -z "$nodejs" ]
	then
		nodejsresult="NULL"
	else
		nodejsresult="string exists"
fi
echo $nodejsresult
exit 0
