#!/bin/bash


usage=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo)
count=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)
total=$(awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo)
available=$(awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo)
tanggal=$(cat /sys/class/rtc/rtc0/date)
waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)

echo "[$tanggal $waktu] - Fragment Usage [$usage] - Fragment Count [$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)] - Details [Total: $total, Available: $available]"

