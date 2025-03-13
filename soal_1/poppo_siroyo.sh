#!/bin/bash

#download (i)
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv

#filter (a)
awk -F, '$2 == "Chris Hemsworth" { count++ } END { print "Chris Hemsworth membaca " count " buku." }' reading_data.csv

#hitung rata durasi baca (b)
awk -F, '{ total += $6; count++ } END { if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah " total / count " menit."; else print "Salah." }' reading_data.csv

