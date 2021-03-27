#!/bin/bash

download_func(){
    
    for ((i=1; i<24; i=i+1))
    do
        echo -e "i=$i\n"
        wget -O "$2_$i.jpg" -o ->> Foto.log $1
    done

    files="$( find -type f )"
        for file1 in $files; do
            for file2 in $files; do
                # echo "checking $file1 and $file2"
                if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
                    if diff "$file1" "$file2" > /dev/null; then
                        # echo "$file1 and $file2 are duplicates"
                        rm -v "$file2"
                    fi
                fi
            done
        done

    j=1
    for file in *.jpg; do
        if [[ $j -lt 10 ]]; then
            mv "$file" "./Koleksi_0$j.jpg"
        else
            mv "$file" "./Koleksi_$j.jpg"
        fi
        j=$[$j+1]
    done

    #move hasil download kucing ke folder
    tanggal=$(date +'%d-%m-%Y')
    namafolder="$2_$tanggal"
    mkdir "$namafolder"
    mv ./Koleksi_* ./Foto.log "./$namafolder/" 

    echo "File has been moved to $namafolder"
        
}

n_kucing=$(ls | grep -e "Kucing.*" | wc -l)
n_kelinci=$(ls | grep -e "Kelinci.*" | wc -l)

#kondisi kucing
if [ $n_kucing -eq $n_kelinci ] 
then 
    echo "download kucing"
    url=https://loremflickr.com/320/240/kitten
    download_func "$url" "Kucing"
 
#kondisi  kelinci 
else
    echo "download kelinci"
    url=https://loremflickr.com/320/240/bunny
    download_func "$url" "Kelinci"  
fi