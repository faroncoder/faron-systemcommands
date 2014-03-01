#!/bin/bash
DIRCOMM="$HOME/bin/commands/vault/systemengine/installer/dats"
################################
echo "$1" >> $DIRCOMM/faron-aptget.list
echo "apt package added"
exit 0
