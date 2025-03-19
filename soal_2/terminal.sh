#!/bin/bash

dir="data"
file="player.csv"
database="$dir/$file"

mkdir -p "$dir"
if [ ! -f "$database" ]; then
	echo "id,email,username,password" > "$database"
fi

source ./register.sh
source ./login.sh
source ./scripts/manager.sh

show_menu() {
    echo "========================="
    echo "   IT-01 Authentication  "
    echo "========================="
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    echo "========================="

}
clear
show_menu
while true;do
	read -p "Your choice: " choice

	case $choice in
	1)
		if register_user; then
			password=$(echo -n "IT01-$password-SISOPEZGAMING" | sha256sum | awk '{print $1}')

			if [ -s "$database" ]; then
				id=$(($(tail -n 1 "$database" | cut -d ',' -f1) + 1))
			else
				id=1
			fi

			echo "$id,$email,$username,$password" >> "$database"
			clear
			show_menu
			echo "Registration successful! ✅"
		fi
		;;
	2)
		if login_user; then
			clear
			manager_menu
			echo -e "\nLogin success! ✅"
			while true;do
				manager
			done
		fi
		;;
	3)
		echo "Exiting!..."
		exit 0
		;;
	*)
		echo "Invalid choice!"
		;;
	esac

done



