#!/bin/bash

login_user() {
	validate_email() {
		local email="$1"
		if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
			return 0
		else
			clear
			show_menu
			echo -e "\nInvalid email format."
			return 1
		fi
	}

	read -p "Enter your email: " email
	if ! validate_email "$email"; then
		return 1
	fi

	read -s -p "Enter your password: " password
	echo

	check=$(awk -F, -v email="$email" -v hash=$(echo -n "IT01-$password-SISOPEZGAMING" | sha256sum | awk '{print $1}') 'NR>1 && $2==email && $4==hash {print $2}' "$database")
	if [[ "$check" == "$email" ]]; then
		return 0
	else
		clear
		show_menu
		echo -e "\nInvalid username or password."
		return 1
	fi
}

