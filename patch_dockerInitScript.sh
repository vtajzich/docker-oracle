#!/bin/bash

echo "Patching startup script"

IFS=: read -r number line <<< $(grep -n '# keep container runing' /home/oracle/setup/dockerInit.sh)
lines=$(cat /home/oracle/setup/dockerInit.sh | wc -l)

echo "Removing lines (${number} > ${lines})"

sed -i.bak "${number},${lines}d" /home/oracle/setup/dockerInit.sh