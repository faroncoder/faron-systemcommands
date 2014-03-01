#!/bin/bash
DIRCOMM="$HOME/bin/commands/vault/systemengine/installer/dats"
################################
echo -n "name of command? "
read newcom
echo -n "What command to add? "
read comm
echo 'alias $newcom=\"$comm\"' >> $DIRCOMM/commands.dat
echo "command added"
exit 0
