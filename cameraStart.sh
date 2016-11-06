#!/bin/bash
# cameraStart.sh
# ------------
# Note: Nahravani z IP camery na NAS disk. Pomoci cron je zajisteny  spravny chod smycky.
# -----------
# Author: @smoce.net

# RTSP source camera
RTSP="rtsp://192.168.1.12:554/user=username&password=password&channel=1&stream=0.sdp?real_stream"

# PERIOD Record
PERIODTIME="900"  
#900s => 15 minut

# Format datumu slozky
name="`date +%Y-%m-%d`"

# Format datumu v nazvu souboru
name1="`date +%Y-%m-%d-%T`"

# Prefix v nazvu souboru
PREFIXname='car'

# Slozka kam bude script ukladat nahravku
BASEpath='/media/camera/record'

# nesahat
RECpath=$BASEpath'/'$name

echo "Camera record: " $name
echo "Save folder: " $RECpath

if [ ! -d $RECpath ]; then
    mkdir -p $RECpath;
fi;
 

PROCESS="avconv"
PIDS=`ps cax | grep $PROCESS | grep -o '^[ ]*[0-9]*'`
if [ -z "$PIDS" ]; then
  echo "Process starting..." 1>&2
else
 if [ -z "$1" ]; then
  for PID in $PIDS; do
    echo "KILL pid: " $PID
    pkill avconv
  done
 else
    echo "Process exist...Exit.." 
    exit 1;
 fi
fi

cd $RECpath 

# Problem consistency video..
#avconv -i $RTSP -c:v copy -map 0:0 -profile:v baseline -level 30  -f segment -segment_time $PERIODTIME -segment_format mp4 "${PREFIXname}_${name1}_%04d.mp4"

# OK 
avconv -i $RTSP -c copy -map 0:0 -f segment -segment_time 1800 -segment_format mkv "${PREFIXname}_${name1}_%04d.mp4"

