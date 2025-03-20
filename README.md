# LAPORAN PRAKTIKUM SISTEM OPERASI MODUL 1 KELOMPOK IT01

  |       Nama        |     NRP    |
  |-------------------|------------|
  | Ahmad Idza Anafin | 5027241017 |
  | Ivan Syarifuddin  | 5027241045 |
  | Diva Aulia Rosa   | 5027241003 |


# Soal 1
  
  1. `kode_file="1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV" & nama_file="reading_data.csv"` : ini hanya inisiasi untuk kode URL dari file CSV yang akan diunduh, dan inisiasi untuk nama file. hal ini dilakukan agar lebih mudah saja.
  2. `wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$kode_file" -O "$nama_file"` : `wget` perintah untuk mengunduh file dari drive, `-q --no-check-certificate` adalah perintah untuk menjalankan semuanya dalam mode diam dan mengabaikan pengecekan keamanan, `-O "$nama_file"` adalah perintah untuk menyimpan file unduhan sesuai yang ditentukan.
  3. Karena dalam soal diminta menggunakan IF ELSE untuk memanggil jawaban di setiap soal, maka disini kita membuat fungsi disetiap soalnya
  4. `jumlah_buku() {
  awk -F, '
  BEGIN {count = 0}
  $2 == "Chris Hemsworth" { count++ }
  END {
          if (count > 0){
          print "Chris Hemsworth membaca "count " buku."
          } else {
          print "coba lagi"
          }
  }' "$nama_file"
  }` : `jumlah_buku()` adalah sebuah fungsi yang akan dijalankan ketika dipanggil. `awk -F,` adalah perintah untuk memfilter dan mengubah data (Field Separator) yang dipisahkan dengan koma. `BEGIN {count = 0}` bagian yang dijalankan sebelum pemrosesan baris dimulai. Di sini, variabel count diinisialisasi ke nilai 0 untuk menghitung jumlah buku. `$2 == "Chris Hemsworth" { count++ }` perintah untuk mengecek apakah kolom kedua dalam file mengandung teks "Chris Hemsworth". Jika cocok, variabel count akan bertambah 1. `END { }` semua proses di dalamnya adalah bagian yang dijalankan setelah semua baris file selesai diproses. Nah bagian ini akan mencetak hasilnya. `if (count > 0)` adalah syarat apabila count lebih dari 0 maka akan ` print "Chris Hemsworth membaca "count " buku."` mencetak Chris Hemsworth membaca "count " buku. Nah count ini akan diisi jumlah dari buku yang dibaca sesuai dengan filter yang dilakukan. `else {print "coba lagi"}` perintanih ini dilakukan pada saat syarat tidak terpenuhi (count lebih kecil dari 0). `"$nama_file"  ` adalah file yang diproses sesuai yang diinisiasi di awal.
  5. `rata_rata_durasi() {
  awk -F, '
  BEGIN{
          total = 0
          count = 0
  }
  {       if ($8 == "Tablet") {
                  total += $6
                  count++ }
  }
  END {
          if (count > 0) {
                  print "Rata-rata durasi membaca dengan Tablet adalah " total / count " menit."
          } else {print "coba lagi." }
  }' "$nama_file"
  }` : `rata_rata_durasi()` adalah sebuah fungsi yang akan dijalankan ketika dipanggil. `awk -F,` adalah perintah untuk memfilter dan mengubah data (Field Separator) yang dipisahkan dengan koma. `BEGIN{
          total = 0
          count = 0
  }` bagian yang dijalankan sebelum pemrosesan baris dimulai. Variabel total digunakan untuk menyimpan total durasi, sementara count digunakan untuk menghitung jumlah entri/data yang sesuai kriteria. `{        if ($8 == "Tablet") {
                  total += $6
                  count++ }
  }` ini berarti untuk mengecek apakah kolom ke-8 berisi teks "Tablet". Apabila ditemukan maka akan dilakukan `total += $6` Nilai di kolom ke-6 (durasi) ditambahkan ke variabel total. count++: Variabel count dinaikkan sebanyak 1 untuk menghitung jumlah entri/data yang sesuai. `END { }` semua proses di dalamnya adalah bagian yang dijalankan setelah semua baris file selesai diproses. Nah bagian ini akan mencetak hasilnya. `if (count > 0)` adalah syarat apabila count lebih dari 0 maka akan `print "Rata-rata durasi membaca dengan Tablet adalah " total / count " menit."` mencetak Rata-rata durasi membaca dengan Tablet adalah " total / count " menit." Nah karena yang diminta adalah rata-rata jadi total durasi akan dibagi dengan jumlah data ini di lakukan pada `" total / count "`. `else {print "coba lagi"}` perintah ini dilakukan pada saat syarat tidak terpenuhi (count lebih kecil dari 0). `"$nama_file"` adalah file yang diproses sesuai yang diinisiasi di awal.
  6. `rating_tertinggi() {
  awk -F, '
  BEGIN {rating = 0}
  NR > 1 {
          if ($7 > rating) {
                  rating = $7
                  nama = $2
                  judul = $3
          }
  }
  END {
          if (rating > 0) {
          print "Pembaca dengan rating tertinggi:", nama, "-", judul, "-", rating
          } else { print "coba lagi."}
  }' "$nama_file"
  }` : `rating_tertinggi()` adalah sebuah fungsi yang akan dijalankan ketika dipanggil. `awk -F,` adalah perintah untuk memfilter dan mengubah data (Field Separator) yang dipisahkan dengan koma. `BEGIN {rating = 0}` bagian yang dijalankan sebelum pemrosesan baris dimulai. Variabel rating diinisialisasi ke 0 sebagai nilai awal. Ini digunakan untuk menyimpan rating tertinggi. `NR > 1` memastikan hanya baris di luar header (baris pertama) yang diproses. Biasanya, baris pertama file CSV berisi nama-nama kolom, jadi ini dilewati. `if ($7 > rating)` adalah sebuah kondisi dimana nilai dari kolom ke-7 yang merupakan kolom rating) diperiksa. `rating = $7 nama = $2 judul = $3`Jika lebih besar dari rating saat ini, maka rating diperbarui dengan nilai yang baru, nama pembaca disimpan ke dalam variabel nama, judul buku disimpan ke dalam variabel judul. `END { }` semua proses di dalamnya adalah bagian yang dijalankan setelah semua baris file selesai diproses. Nah bagian ini akan mencetak hasilnya. `if (rating > 0)` adalah syarat apabila data terakhir dari variabel rating lebih dari 0 maka akan `print "Pembaca dengan rating tertinggi:", nama, "-", judul, "-", rating` untuk nama diisi dengan data terakhir dari variabel nama, bgitu juda dengan judul dan rating. `else {print "coba lagi"}` perintah ini dilakukan pada saat syarat tidak terpenuhi (count lebih kecil dari 0). `"$nama_file"` adalah file yang diproses sesuai yang diinisiasi di awal.
  7. `genre_populer() {
  awk -F, '
  BEGIN {tukar = 0}
  NR > 1 {
          if ($9 == "Asia" && $5 >= "2023-12-31") {
                  genre[$4]++
          }
  }
  END {
          for (x in genre) {
                  if (genre[x] > tukar){
                  tukar = genre[x]
                  populer = x
          }
  }
  if (tukar > 0) {
          print "Genre paling populer di Asia setelah 2023 adalah", populer, "dengan", tukar, "buku."
          } else {print "coba lagi."}
  }' "$nama_file"
  }` : `genre_populer()` adalah sebuah fungsi yang akan dijalankan ketika dipanggil. `awk -F,` adalah perintah untuk memfilter dan mengubah data (Field Separator) yang dipisahkan dengan koma. `BEGIN {tukar = 0}` bagian yang dijalankan sebelum pemrosesan baris dimulai. variabel tukar digunakan untuk menyimpan jumlah buku terbanyak dari genre yang ditemukan (genre paling populer). `NR > 1` memastikan hanya baris di luar header (baris pertama) yang diproses. Biasanya, baris pertama file CSV berisi nama-nama kolom, jadi ini dilewati. `if ($9 == "Asia" && $5 >= "2023-12-31")` adalah sebuah kodisi filter apabila pada kolom 9 (wilayah) ada kata `Asia` dan kolom 5 (tanggal) lebih dari 31 Desember 2023, maka ` genre[$4]++` genre buku pada kolom 4 akan dihitung dan menyimpan jumlah buku. Kemudian dilakukan iterasi disetiap genre, dan membandingkan setiap jumlah buku dari semua genre, apabila jumlah buku dari setiap genre lebih besar dari variabel tukar maka data akan diperbarui dan disimpan dalam variabel populer. `if (tukar > 0)` apabila variabel tukar lebih besar dari 0 maka akan `print "Genre paling populer di Asia setelah 2023 adalah", populer, "dengan", tukar, "buku."` untuk populer berisi genre yang paling populer, dan tukar berisi jumlah bukunya. `else {print "coba lagi"}` perintah ini dilakukan pada saat syarat tidak terpenuhi (count lebih kecil dari 0). `"$nama_file"` adalah file yang diproses sesuai yang diinisiasi di awal.
  
  8. `echo "Pilih soal a,b,c,d:"
  read -p "Masukkan pilihan: " soal
  if [[ $soal == "a" ]] then
          jumlah_buku
  elif [[ $soal == "b" ]] then
          rata_rata_durasi
  elif [[ $soal == "c" ]] then
          rating_tertinggi
  elif [[ $soal == "d" ]] then
          genre_populer
  else echo "pilihan tidak tersedia."
  fi` : digunakan untuk memanggil jawaban dari soal yang akan dipilih oleh user `echo "Pilih soal a,b,c,d:` ini akan memnuculkan kalimat "Pilih soal a,b,c,d :" pada layar pengguna. `read -p "Masukkan pilihan: " soal` untuk menerima input user dan menampilkan "Masukkan pilihan:" dan pilihan user akan disimpan dengan variabel soal, `if [[ $soal == "a" ]] then
          jumlah_buku
  elif [[ $soal == "b" ]] then
          rata_rata_durasi
  elif [[ $soal == "c" ]] then
          rating_tertinggi
  elif [[ $soal == "d" ]] then
          genre_populer` ini untuk kondisi dari apa yang diinputkan oleh user, dan akan memanggil fungsi/jawaban dari soal. `else echo "pilihan tidak tersedia."` ini akan dijalankan apabila user memasukkan opsi yang tidak tersedia. Dan `fi` adalah penutup untuk kondisi if elif else.


# Soal 2 

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
**UPDATE: menambahkan opsi exit pada terminal**

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


# Soal 3


# Soal 4
**Diberikan file csv "pokemon_usage.csv" kemudian diminta untuk membuat script untuk mempermudah analisis csv tersebut. Dimana program harus memiliki ketentuan fitur/option berikut:**
- **--info : melihat summary pokemon yang memiliki nilai tertinggi untuk column Usage%, dan nilai tertinggi untuk column Raw Usage**
- **--sort <column> : melakukan sorting secara alphabetic jika sort berdasarkan nama, dan secara descending untuk column yang berisi angka**
- **--grep <name> : melakukan searching nama pokemon yang mengandung kata yang di search (tidak spesifik)**
- **--filter <type> : melakukan filter pada column Type1 dan Type2 berdasarkan value yang diberikan**
- **--help : menampilkan interface help menu program**

**dan program dijalankan dengan ./<name_program.sh> <name_file.csv> <program_option> <optional_value>**

## pokemon_analysis.sh
  ```
   #!/bin/bash

file_id="1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ"
name_file="pokemon_usage.csv"

#download
#wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$file_id" -O "$name_file"

print_help() {
    message=$1


    cat <<EOF
    ██╗████████╗░░░░░░░█████╗░░██╗░░
    ██║╚══██╔══╝░░░░░░██╔══██╗░██║░░
    ██║░░░██║░░░█████╗██║░░██║░██║░░
    ██║░░░██║░░░╚════╝██║░░██║░██║░░
    ██║░░░██║░░░░░░░░░╚█████╔╝░██║░░
    ╚═╝░░░╚═╝░░░░░░░░░░╚════╝░░╚═╝░░
    Welcome to Pokemon Analysis CLI!

EOF
    echo -e "     \e[31m$message\e[0m"

    cat <<EOF

    Usage:
      ./pokemon_analysis.sh <file.csv> <command> [options]

    Commands:
      --info            Show summary of Pokemon usage
      --sort <column_number>   Sort data by specified column
        column:
$available_column
      --grep <name>     Search Pokemon by name
      --filter <type>   Filter Pokemon by type
      -h, --help        Show this help message

EOF
}

if [ $# -lt 2 ]; then
    print_help "Not enough arguments provided."
    exit 1
fi

FILE=$1
COMMAND=$2
OPTION=$3
available_column=$(awk -F, 'NR==1 { for (i=1; i<=NF; i++) print "\t\t" i ". " $i }' $FILE)


if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist."
    exit 1
fi

case $COMMAND in
    --info)
        echo "Summary of $FILE"
        cat $FILE | sort -t, -k2 -nr | head -1 | awk -F, '{print "Highest Adjusted Usage: "$1 " " $2}'
        cat $FILE | sort -t, -k3 -nr | head -1 | awk -F, '{print "Highest Raw Usage: "$1 " " $3 " uses"}'
        ;;

    --sort)
        if [ -z "$OPTION" ]; then
            print_help "no column number provided."
            exit 1
        fi

        n=$(head -1 $FILE | awk -F, '{print NF}')
        case_stmt="case \$OPTION in"
        for ((i=1; i<=n; i++)); do
            case_stmt+="
            $i) COL=$i ;;"
        done
        case_stmt+="
            *) print_help \"Invalid sort column \$OPTION\"; exit 1 ;;
        esac"

        eval "$case_stmt"
                (head -n 1 "$FILE" && tail -n +2 "$FILE" | sort -t, -k$COL,$COL $([ "$OPTION" == "1" ] && echo "" || echo "-nr"))
        ;;

    --grep)
        if [ -z "$OPTION" ]; then
            print_help "no search term provided."
            exit 1
        fi
        (head -n 1 "$FILE" )
        awk -F',' -v opt="$OPTION" 'tolower($1) ~ tolower(opt) {print; found=1} END {if (!found) print "Pokemon Not found"}' $FILE | sort -t, -k2 -nr
        ;;

    --filter)
        if [ -z "$OPTION" ]; then
            print_help "no filter option provided."
            exit 1
        fi
        (head -n 1 "$FILE")
        awk -F, -v type="$OPTION" 'tolower($4) == tolower(type) || tolower($5) == tolower(type)' $FILE | sort -t, -k2 -nr
        ;;
    -h|--help)
        print_help
        ;;
    *)
        print_help "Unknown command $COMMAND."
        exit 1
        ;;
esac
  ```

### Melihat summary data (--info)
- melakukan sorting menggunakan command sort dan awk untuk mengambil spesifik column
    ```
    --info)
        echo "Summary of $FILE"
        cat $FILE | sort -t, -k2 -nr | head -1 | awk -F, '{print "Highest Adjusted Usage: "$1 " " $2}'
        cat $FILE | sort -t, -k3 -nr | head -1 | awk -F, '{print "Highest Raw Usage: "$1 " " $3 " uses"}'
        ;;
    ```
### Sorting based column (--sort <column>)
- melakukan filter menggunakan awk dengan mencari pada kolom yang diinput dan di pipe menggunakan sorting descending jika kolom berisi angka dan alphabetic jika kolom nama
    ```
    --sort)
        if [ -z "$OPTION" ]; then
            print_help "no column number provided."
            exit 1
        fi

        n=$(head -1 $FILE | awk -F, '{print NF}')
        case_stmt="case \$OPTION in"
        for ((i=1; i<=n; i++)); do
            case_stmt+="
            $i) COL=$i ;;"
        done
        case_stmt+="
            *) print_help \"Invalid sort column \$OPTION\"; exit 1 ;;
        esac"

        eval "$case_stmt"
                (head -n 1 "$FILE" && tail -n +2 "$FILE" | sort -t, -k$COL,$COL $([ "$OPTION" == "1" ] && echo "" || echo "-nr"))
        ;;
    ```
### Melakukan searching nama pokemon (--grep <nama_pokemon>)
- melakukan filter menggunakan awk dengan mencari pada kolom 1 (nama) dan di pipe menggunakan sorting descending berdasarkan kolom usage
    ```
     --grep)
        if [ -z "$OPTION" ]; then
            print_help "no search term provided."
            exit 1
        fi
        (head -n 1 "$FILE" )
        awk -F',' -v opt="$OPTION" 'tolower($1) ~ tolower(opt) {print; found=1} END {if (!found) print "Pokemon Not found"}' $FILE | sort -t, -k2 -nr
        ;;
    ```
### Melakukan filtering type (--filter <type>)
- melakukan filter menggunakan awk dengan mencari pada kolom 4 dan 5 (Type 1 dan Type 2) dan di pipe menggunakan sorting descending berdasarkan kolom usage
    ```
    --filter)
        (head -n 1 "$FILE")
        awk -F, -v type="$OPTION" 'tolower($4) == tolower(type) || tolower($5) == tolower(type)' $FILE | sort -t, -k2 -nr
        ;;
    ```
### Error handling
- melakukan validasi pada setiap option jika ada argument yang tidak sesuai
    ```
     if [ -z "$OPTION" ]; then
            print_help "no filter option provided."
            exit 1
     fi
     if [ $# -lt 2 ]; then
      print_help "Not enough arguments provided."
      exit 1
     fi

     if [ -z "$OPTION" ]; then
            print_help "no column number provided."
            exit 1
     fi
     if [ -z "$OPTION" ]; then
            print_help "no search term provided."
            exit 1
     fi
     if [ -z "$OPTION" ]; then
            print_help "no filter option provided."
            exit 1
     fi
    ```
### Menampilkan help (--help)
- Memanggil fungsi print_help yang berisi tampilan menu
    ```
     -h|--help)
        print_help
        ;;
    ```
