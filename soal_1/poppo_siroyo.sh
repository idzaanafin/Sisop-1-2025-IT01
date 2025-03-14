#!/bin/bash

kode_file="1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV"
nama_file="reading_data.csv"

#download file (i)
wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$kode_file" -O "$nama_file"



#jumlah buku (a)
awk -F, '$2 == "Chris Hemsworth" { count++ } END { print "Chris Hemsworth membaca "count " buku."}' "$nama_file"



#rata_rata durasi baca (b)
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



#rating tinggi (c)
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



#genre populer (d)
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
	} else {
	print "coba lagi."
}
}' "$nama_file"

