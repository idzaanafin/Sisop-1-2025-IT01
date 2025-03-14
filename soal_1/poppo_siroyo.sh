#!/bin/bash

file_id="1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV"
name_file="reading_data.csv"

#download
wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$file_id" -O "$name_file"

#filter
awk -F, '$2 == "Chris Hemsworth" { count++ } END { print "Chris Hemsworth membaca " count " buku." }' "$name_file"

awk -F, '$8 == "Tablet" {sum+=$7; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah " sum/count " menit"}' "$name_file"

awk -F',' 'NR > 1 {if ($7 > max) {title = $3;max = $7; name = $2}} END {print "Pembaca dengan rating tertinggi: " name " - " title  " - " max}' "$name_file"
