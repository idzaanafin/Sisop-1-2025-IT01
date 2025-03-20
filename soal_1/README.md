# SOAL 1 MODUL 1 SISOP

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
}` : `jumlah_buku()` adalah sebuah fungsi yang akan dijalankan ketika dipanggil. `awk -F,` adalah perintah untuk memfilter dan mengubah data (Field Separator) yang dipisahkan dengan koma. `BEGIN {count = 0}` bagian yang dijalankan sebelum pemrosesan baris dimulai. Di sini, variabel count diinisialisasi ke nilai 0 untuk menghitung jumlah buku. `$2 == "Chris Hemsworth" { count++ }` perintah untuk mengecek apakah kolom kedua dalam file mengandung teks "Chris Hemsworth". Jika cocok, variabel count akan bertambah 1. `END { }` semua proses di dalamnya adalah bagian yang dijalankan setelah semua baris file selesai diproses. Nah bagian ini akan mencetak hasilnya. `if (count > 0)` adalah syarat apabila count lebih dari 0 maka akan `	print "Chris Hemsworth membaca "count " buku."` mencetak Chris Hemsworth membaca "count " buku. Nah count ini akan diisi jumlah dari buku yang dibaca sesuai dengan filter yang dilakukan. `else {print "coba lagi"}` perintanih ini dilakukan pada saat syarat tidak terpenuhi (count lebih kecil dari 0). `"$nama_file"	` adalah file yang diproses sesuai yang diinisiasi di awal.
5. `rata_rata_durasi() {
awk -F, '
BEGIN{
	total = 0
	count = 0
}
{	if ($8 == "Tablet") { 
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
}` bagian yang dijalankan sebelum pemrosesan baris dimulai. Variabel total digunakan untuk menyimpan total durasi, sementara count digunakan untuk menghitung jumlah entri/data yang sesuai kriteria. `{	if ($8 == "Tablet") { 
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
