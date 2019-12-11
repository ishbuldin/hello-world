#!/bin/bash
ping -c 1 fs-node1 > /dev/null 2>&1 ;NODE1=$?
ping -c 1 fs-node2 > /dev/null 2>&1 ;NODE2=$?
CLUSTER=$(pcs status | sed -n '10p;10q' | awk '{print $1}')
if [[ $NODE1 == 0 ]] && [[ $NODE2 == 0 ]] && [[ "$CLUSTER" != "Online:" ]]; then
   pcs resource cleanup
   echo CLUSTER = $CLUSTER executed command - PCS RESOURCE CLEANUP | mail -s "From cluster freeswitch" ishbuldin@skbkontur.ru
fi
