#!/bin/bash


all=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
current=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))

tanggal=$(cat /sys/class/rtc/rtc0/date)
waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)
model=$(awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo)

echo "[$tanggal $waktu] - Core Usage [$current] - Terminal Model [$model]"
