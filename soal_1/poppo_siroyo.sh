#!/bin/bash

file_id="1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV"
name_file="reading_data.csv"

#download
wget -q --no-check-certificate "https://docs.google.com/uc?export=download&id=$file_id" -O "$name_file"

#filter
awk -F, '$2 == "Chris Hemsworth" { count++ } END { print "Chris Hemsworth membaca " count " buku." }' "$name_file"

