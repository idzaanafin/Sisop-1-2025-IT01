# SOAL 2 MODUL 1 SISOP

**Pada soal ini diharuskan untuk membuat program manager untuk menambahkan schedule log monitoring CPU dan RAM ke cronjob. Juga terdapat fitur login register untuk mengkases dashboard manager tersebut. Jadi secara singkat alur programnya:**
- **Menu Autentikasi untuk Register dan Login**
```
=========================
   IT-01 Authentication
=========================
1. Register
2. Login
3. Exit
=========================
Your choice:
```
- **Menu manager yang dapat diakses setelah login. Pada menu ini mempunyai beberapa fitur berikut**
```
=========================
 IT-01 Dashboard Manager
=========================
1. Add CPU - Core Monitor
2. Add RAM - Fragment Monitor
3. Remove CPU - Core Monitor
4. Remove RAM - Fragment Monitor
5. View All Jobs
6. Logout & Exit
=========================

Login success! ✅

Enter option [1-6]:
```
**program diatas disusun dengan struktur file berikut**
```
├── data
│   └── player.csv
├── login.sh
├── register.sh
├── scripts
│   ├── core_monitor.sh
│   ├── frag_monitor.sh
│   ├── logs
│   └── manager.sh
└── terminal.sh
```

## data/player.csv
- berfungsi sebagai database untuk menyimpan informasi email, username, password user
  ```
  id,email,username,password
  1,a@a.com,a,8a307827e13673eac8429eef2c6bd37eaa2f06f85501cc8ae19d7c252414c717
  ```

## register.sh
```
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
```
#### Input email, username, password
- Program akan meminta input user dengan melakukan checking terlebih dahulu, jika pass semua maka fungsi register akan return True 
  ```
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
  ```
#### Validasi Input
- validasi input untuk email wajib mengandung '@','.', dan domain minimal 2 karakter contoh 'id','com'. Valdasi ini menggunakan regex
  ```
   "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ 
  ```
- validasi duplikasi email untuk memastikan bahwa user tidak bisa registrasi menggunakan email yang sama. Menggunakan grep untuk melihat pada database dan dilakukan setelah melewati validasi email yang pertama
  ```
  if grep -q ",$email," "$database"; then
                clear
                show_menu
                echo -e "\nEmail already registered."
                return 1
  fi
  ```
- Validasi password minimal mengandung lowercase, uppercase, dan angka
  ```
  ${#password} -ge 8 && "$password" =~ [a-z] && "$password" =~ [A-Z] && "$password" =~ [0-9]
  ```

## login.sh
```
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
```
#### Input email dan password
- pada fungsi login akan meminta input user yaitu email dan password dan menerapkan validasi yang sama dengan fungsi register
    ```
    read -p "Enter your email: " email
        if ! validate_email "$email"; then
                return 1
        fi

    read -s -p "Enter your password: " password
    ```
#### Autentikasi
- Kode yang akan melakukan autentikasi untuk mengecek informasi input user yaitu kredensial pada database, jika benar maka fungsi login return true
  ```
  check=$(awk -F, -v email="$email" -v hash=$(echo -n "IT01-$password-SISOPEZGAMING" | sha256sum | awk '{print $1}') 'NR>1 && $2==email && $4==hash {print $2}' "$database")
  if [[ "$check" == "$email" ]]; then
          return 0
  else
          clear
          show_menu
          echo -e "\nInvalid username or password."
          return 1
  fi
  ```


## terminal.sh
```
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
```
#### Database preparation
- terminal.sh sebagai main program, jadi ketika dijalankan sekaligus melakukan konfigurasi database (membuat dan mengecek folder), juga memanggil fungsi login dan register pada file yang terpisah
    ```
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
    ```
#### Interface menu
- Menampilkan menu sebagai interface user, dan menerima input user
  ```
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
  ```
#### Fungsi Utama
- jika input user adalah 1 maka akan memanggil fungsi register. Jika return True maka program akan menyimpan informasi ke database
  ```
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
  ```
- jika input user 2 akan memanggil fungsi login. Jika return True maka program akan memanggil fungsi manager pada manager.sh
  ```
  if login_user; then
          clear
          manager_menu
          echo -e "\nLogin success! ✅"
          while true;do
                  manager
          done
  fi
  ```
  - jika 3 maka program akan berhenti
  ```
  echo "Exiting!..."
  exit 0
  ```

## script/manager.sh
```
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
```
#### Variable dan fungsi pembantu tambahan
- fungsi untuk mengecek apakah script sudah ada pada cronjob
    ```
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
    ```
#### Menu dan input user
- Menampilkan menu dan menerima input user
  ```
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
  ```
#### Fungsi utama manager
- Jika input 1 akan menambahkan script schedule CPU monitoring pada cronjob via file /eetc/crontab
  ```
  if check_core_monitor; then
          clear
          manager_menu
          echo -e "\nCPU - Core monitoring script has been scheduled"
  else
          echo "* * * * * $USER $path/$CORE_MONITOR_SCRIPT >> $path/logs/core.log" >> $CRON_FILE
          service cron restart
          clear
          manager_menu
          echo -e "\nCPU - Core monitoring script successfully added to schedule."
  fi
  ```
- Jika input 2 akan menambahkan script schedule RAM monitoring pada cronjob via file /etc/crontab
  ```
  if check_frag_monitor; then
          clear
          manager_menu
          echo -e "\nRAM - Fragment monitoring script has been scheduled"
  else
          echo "* * * * * $USER $path/$FRAG_MONITOR_SCRIPT  >> $path/logs/fragment.log" >> $CRON_FILE
          service cron restart
          clear
          manager_menu
          echo -e "\nRAM - Fragment monitoring successfully added to schedule."
  fi
  ```
- Jika input 3 akan meremove script CPU monitoring dari schedule emnggunakan sed
  ```
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
  ```
- Jika input 4 akan meremove script RAM monitoring dari schedule emnggunakan sed
  ```
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
  ```
- Jika input 5 akan menampilkan schedule yang sudah ditambahkan
   ```
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
   ```
- Jika input 6 maka program akan berhenti
  ```
  echo "Exiting..."
  exit 0
  ```

## script/core_monitor.sh
```
#!/bin/bash
all=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
current=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))

tanggal=$(cat /sys/class/rtc/rtc0/date)
waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)
model=$(awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo)

echo "[$tanggal $waktu] - Core Usage [$current] - Terminal Model [$model]"
```
#### time
- untuk mendapatkan data waktu (tanpa command date), mengambil data dari file /sys/class/rtc/rtc0/time dan /sys/class/rtc/rtc0/date untuk tanggal
  ```
  tanggal=$(cat /sys/class/rtc/rtc0/date)
  waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)
  ```
#### current usage
- untuk mendapatkan data current usage cpu mengambil data dari file /proc/stat
  ```
  current=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))
  ```
#### terminal model
- untuk mendapatkan data terminal model mengambil data dari file /proc/cpuinfo
  ```
  model=$(awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo)
  ```
  
## script/frag_monitor.sh
```
#!/bin/bash

usage=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo)
count=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)
total=$(awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo)
available=$(awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo)
tanggal=$(cat /sys/class/rtc/rtc0/date)
waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)

echo "[$tanggal $waktu] - Fragment Usage [$usage] - Fragment Count [$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)] - Details [Total: $total, Available: $available]"
```
#### Time
- untuk mendapatkan data waktu (tanpa command date), mengambil data dari file /sys/class/rtc/rtc0/time dan /sys/class/rtc/rtc0/date untuk tanggal
  ```
  tanggal=$(cat /sys/class/rtc/rtc0/date)
  waktu=$(awk -F: '{print ($1+7)%24":"$2":"$3}' /sys/class/rtc/rtc0/time)
  ```
#### Data RAM
- untuk mendapatkan semua informasi memori mendapatkan data dari file /proc/meminfo
  ```
  usage=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)*100/total "%"}' /proc/meminfo)
  count=$(awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print (total-avail)/1024 " MB"}' /proc/meminfo)
  total=$(awk '/MemTotal/ {print $2/1024 " MB"}' /proc/meminfo)
  available=$(awk '/MemAvailable/ {print $2/1024 " MB"}' /proc/meminfo)
  ```

## logs/
- direktori ini untuk menyimpan file core.log dan fragment.log jika script log monitoring dijalankan oleh cronjob
  ```
  ── logs
      ├── core.log
      └── fragment.log
  ```
