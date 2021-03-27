#!/bin/bash

bash ./soal3a.sh 

tanggal=$(date +'%d-%m-%Y')
mkdir "$tanggal"
mv ./Koleksi_* ./Foto.log "./$tanggal/" 

echo "File has been moved to $tanggal"
