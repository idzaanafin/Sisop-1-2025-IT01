#!/bin/bash

CRON_FILE="/etc/crontab"
path="/home/idzoyy/sisop-it24/Sisop-1-2025-IT01/soal_2/scripts"
CORE_MONITOR_SCRIPT="core_monitor.sh"
FRAG_MONITOR_SCRIPT="frag_monitor.sh"


check_core_monitor() {
	grep -q "$CORE_MONITOR_SCRIPT" $CRON_FILE
}

check_frag_monitor() {
	grep -q "$FRAG_MONITOR_SCRIPT" $CRON_FILE
}
manager_menu(){
    echo "========================="
    echo " IT-01 Dashboard Manager "
    echo "========================="
    echo "1. Add CPU - Core Monitor "
    echo "2. Add RAM - Fragment Monitor"
    echo "3. Remove CPU - Core Monitor "
    echo "4. Remove RAM - Fragment Monitor "
    echo "5. View All Jobs "
    echo "6. Logout & Exit "
    echo "========================="

}

manager(){
echo
read -p "Enter option [1-6]: " option
case $option in
	1)
		if check_core_monitor; then
			clear
			manager_menu
			echo -e "\nCPU - Core monitoring script has been scheduled"
		else
			echo "* * * * * idzoyy $path/$CORE_MONITOR_SCRIPT >> $path/logs/core.log" >> $CRON_FILE
			service cron restart
			clear
			manager_menu
			echo -e "\nCPU - Core monitoring script successfully added to schedule."
		fi
	;;
	2)
		if check_frag_monitor; then
			clear
			manager_menu
			echo -e "\nRAM - Fragment monitoring script has been scheduled"
		else
			echo "* * * * * idzoyy $path/$FRAG_MONITOR_SCRIPT  >> $path/logs/fragment.log" >> $CRON_FILE
			service cron restart
			clear
			manager_menu
			echo -e "\nRAM - Fragment monitoring successfully added to schedule."
		fi
	;;
	3)
		if check_core_monitor; then
			sed -i "/$CORE_MONITOR_SCRIPT/d" $CRON_FILE
			clear
			manager_menu
			echo -e "\nCPU - Core monitoring script successfully removed from schedule."
		else
			clear
			manager_menu
			echo -e "\nCPU - Core monitoring script not found or not scheduled yet"
		fi
	;;
	4)
		if check_frag_monitor; then
			sed -i "/$FRAG_MONITOR_SCRIPT/d" $CRON_FILE
			clear
			manager_menu
			echo -e "\nCPU - Core monitoring script successfully removed from schedule."
		else
			clear
			manager_menu
			echo -e "\nRAM - Frag monitoring script not found or not scheduled yet"
		fi
	;;
	5)
		clear
		manager_menu
		echo -e "\nAll Schedule Jobs"
		echo "_________________"
		if check_core_monitor && check_frag_monitor; then
			echo -e "\n✅ CPU - Core Monitoring Schedule"
			echo "✅ RAM - Fragment  Monitoring Schedule"
		elif check_core_monitor; then
			echo -e "\n✅ CPU - Core Monitoring Schedule"
		elif check_frag_monitor; then
			echo -e "\n✅ RAM - Fragment  Monitoring Schedule"
		else
			clear
			manager_menu
			echo -e "\n❌ No monitoring jobs found."
		fi
	;;
	6)
		echo "Exiting..."
		exit 0
	;;
	*)
		echo "Invalid option."
	;;
esac
}
