#!/bin/bash

echo "Starting"
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1


# $1 tuh buat argumen pertama di termainal jadi ntar itu yang --play

Baris=$(tput lines) #buat dapetin baris di terminal
Kolom=$(tput cols) #buat dapetin kolom di terminal
simbol=('$' '₤' '€' '¥' '¢' '₹' '₩' '₿' '₣') #simbol buat function money
: $((Baris--)) #biar stay di layar

if [[  "$1" == --play=* ]]; then
	lagu="${1#--play=}"
	case "$lagu" in
		"Speak to Me")  #3a
			clear
			while true
			do
				curl -s  "https://www.affirmations.dev" | jq -r '.affirmation'
				sleep 1
			done
		;;

		"On the Run")  #3b
			clear
			progress=0
			progressmax=100
			panjangbar=100
			while [ $progress -le $progressmax ]
			do
				panjangisi=$((progress * panjangbar / progressmax))
				panjangkosong=$((panjangbar - panjangisi))
				bar=$(printf '*%.0s' $(seq 1 $panjangisi)) #ganti isi progress bar nya disini
				kosong=$(printf ' %.0s' $(seq 1 $panjangkosong))

				printf "\rProgres: [%s%s] %d%%" "$bar" "$kosong" "$progress"

				sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
				progress=$((progress + 1))
			done

			echo -e "\nSelesai ;D"
		;;

		"Time")  #3c
			clear
			while true
			do
				date=$(date '+%A %d/%m/%y %r')
				echo -ne " Today is $date\r"
				sleep 1
			done
		;;

		"Money") #3d
			clear
			while true
			do
			(
			j=$((RANDOM % Kolom +1)) #posisi acak
			d=$((RANDOM % Baris +1)) #panjang acak
				for ((i = 1; i <= Baris; i += 2))
				do
				c=${simbol[RANDOM % ${#simbol[@]}]}
				echo -e "\033[$((i - 1));${j}H\033[32m$c"
				echo -e "\033[${i};${j}H\033[37m$c"
				sleep 0.1
					if [ $i -ge $d ]; then
						echo -e "\033[$((i - d));${j}H "
					fi
				done
				for ((k = i - d; k <= Baris; k++))
				do
					echo -e "\033[${i};${j}H "
					sleep 0.1
				done
			) &
			sleep 0.05
			done

		;;

		"Brain Damage") #3e
			while true
			do
			clear
			echo -e "PID\tUser\t%CPU\t%MEM\tCOMMAND"
			
			for pid in /proc/[0-9]*
			do
			pid=${pid#/proc/}
			if [[ -f /proc/$pid/stat ]]; then
				comm=$(awk '{print $2}' /proc/$pid/stat)
				user=$(ls -ld /proc/$pid | awk '{print $3}')

				#buat ambil cpu usage
				uptime=$(awk '{print $1}' /proc/uptime)
				stat=$(cat /proc/$pid/stat)
				utime=$(echo $stat | awk '{print $14}')
				stime=$(echo $stat | awk '{print $15}')
				starttime=$(echo $stat | awk '{print $22}')
				hz=$(getconf CLK_TCK)
				totaltime=$((utime + stime))
				seconds=$(echo "$uptime - ($starttime / $hz)" | bc)
				cpuusage=$(echo "scale=2; $totaltime * 100 / ($hz * seconds)" | bc 2>/dev/null || echo 0)
			
				#buat hitung memory usage
				memusage=$(awk '/VmRSS/ {print $2}' /proc/$pid/status 2>/dev/null || echo 0)
				totalmem=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
				mempersen=$(echo "scale=2; $memusage * 100 / $totalmem" | bc)
			
				#tampilin hasil
				printf "%-8s %-8s %-6.2f %-6.2f %s\n" "$pid" "$user" "$cpuusage" "$mempersen" "$comm"
			fi;

			done | sort -k3 -nr | head -n 10
			sleep 1

			done
		;;

		*)
		echo "Lagu yang dicari tidak ada"

		;;

	esac
else 
	echo "salah command cuyh woilah"
fi
