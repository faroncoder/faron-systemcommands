#!/bin/bash
tail -n0 -f /home/www/faron/logs/error.log | while read line; do notify-send "Error: www.faron.ca" "$line"; done

