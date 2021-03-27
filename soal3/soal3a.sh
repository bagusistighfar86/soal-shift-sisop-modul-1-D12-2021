#!/bin/bash

for ((i=1; i<24; i=i+1))
do
    echo -e "i=$i\n"
    wget -O "Kitten_$i.jpg" -o ->> Foto.log https://loremflickr.com/320/240/kitten
done

files="$( find -type f )"
    for file1 in $files; do
        for file2 in $files; do
            # echo "cek $file1 and $file2"
            if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
                if diff "$file1" "$file2" > /dev/null; then
                    #echo "$file1 dan $file2 duplikat"
                    rm -v "$file2"
                    k=$[$k-1]
                fi
            fi
        done
    done

j=1
for file in *.jpg; do
    if [[ $j -lt 10 ]]; then
        mv "$file" "Koleksi_0$j.jpg"
    else
        mv "$file" "Koleksi_$j.jpg"
    fi
    j=$[$j+1]
done
