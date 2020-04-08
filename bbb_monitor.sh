#! /bin/bash
# script to monitor BBB server
# https://groups.google.com/forum/#!msg/bigbluebutton-dev/Et2D56iweT0/gFsngKPiEAAJ
# execute this with a cron job. Log file must be in a web accessible place
# Koen Roggemans 2020/04/08
 
datum=$(date +"%F %R")
users=$(mongo --quiet mongodb://127.0.1.1:27017/meteor --eval "db.users.count({connectionStatus: 'online'})")
meetings=$(mongo --quiet mongodb://127.0.1.1:27017/meteor --eval "db.meetings.find()" | grep "meetingEnded\" : false," | wc -l)
audio=$(/opt/freeswitch/bin/fs_cli -x "show channels" | grep total | sed 's/ total.//')

echo -e "$datum,$users,$meetings,$audio" >> bbb_usage.log
