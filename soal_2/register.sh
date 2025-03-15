#!/bin/bash

register_user() {
	validate_email() {
		local email="$1"
		if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
			if grep -q ",$email," "$database"; then
				clear
				show_menu
				echo -e "\nEmail already registered."
				return 1
			fi
			return 0
		else
			clear
			show_menu
			echo -e "\nInvalid email format."
			return 1
		fi
	}

	validate_password() {
		local password="$1"
		if [[ ${#password} -ge 8 && "$password" =~ [a-z] && "$password" =~ [A-Z] && "$password" =~ [0-9] ]]; then
			return 0
		else
			clear
			show_menu
			echo -e "\nPassword must be at least 8 characters long, contain at least one lowercase letter, one uppercase letter, and one number."
		return 1
		fi
	}



	read -p "Enter your email: " email
	if ! validate_email "$email"; then
		return 1
	fi


	read -p "Choose a username: " username
	read -s -p "Choose a password: " password
	if ! validate_password "$password"; then
		return 1
	fi

	echo
	read -s -p "Confirm password: " confirm_password
	echo

	if [ "$password" != "$confirm_password" ]; then
		clear
		show_menu
		echo -e "\nPasswords do not match."
		return 1
	fi

	return 0

}



