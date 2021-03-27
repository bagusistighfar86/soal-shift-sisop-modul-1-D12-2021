# soal-shift-sisop-modul-1-D12-2021
## Anggota Kelompok
| Nama | NRP |
|------|-----|
|Muhammad Bagus Istighfar|05111940000049|
|Rizqi Rifaldi|05111940000068|
|Afdhal Ma'ruf Lukman|05111940007001|

## Soal No 1
## Soal No 2
Untuk mengerjakan soal nomor 2, dibutuhkan data Toko Shisop berupa laporan dengan nama "Laporan-TokoShiSop.tsv"
### Sub Soal 2a
Pada soal 2a, Steven diminta untuk mencari Row ID dan *profit percentage* **terbesar** dari "Laporan-TokoShisop", dan jika lebih dari satu maka RowID yang diambil adalah RowID terbesar.
```shell
awk -F"\t" '
  BEGIN{
    maxpp=0
  }
  {
    if(NR!=1){
      pp=$21/($18-$21)*100
      if(pp>=maxpp){
        maxpp=pp;id=$1
      }
    }
  }
  END{
    printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%\n\n",id,maxpp)
  }
' /home/rizqi/Downloads/Laporan-TokoShiSop.tsv > /home/rizqi/hasil.txt
```
Penjelasan :
* Karena menggunakan awk, maka pertama - tama perlu menulis "awk" dan dideklarasikan *Field Separatornya* yaitu tab.
* Pada Begin didekalarisan variabel untuk menyimpan nilai PP terbesar yaitu maxpp dan awalnya nilainya adalah 0.
* Dikarenakan baris pertama pada Laporan-TokoShiSop adalah nama kolom, maka agar baris pertama dilewati menggunakan percabangan jika NR(nomor baris) tidak sama dengan 1, baru dihitung nilai PP nya.
* Setelah itu menghitung nilai PP dengan rumus yang sudah ditentukan, dengan $21 adalah *profit* dan $18 adalah *sales*, kemudian hasilnya disimpan di variabel pp.
* pp dibandingkan dengan maxpp, dan jika nilai pp pada baris baru nilainya lebih besar dari maxpp yang disimpan, maka nilai maxpp akan diganti dengan nilai pp yang baru, dan RowId pada baris tersebut akan disimpan ke variabel id.
* Pada End, mencetak kalimat dan nilai dari RowID dan maxpp.
* awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di "/home/rizqi/Downloads/Laporan-TokoShiSop.tsv" dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori "/home/rizqi/hasil.txt".
### Sub Soal 2b
Pada soal 2b, Clemong mencari nama customer pada transaksi tahun 2017 di Albuquerque.
```shell
awk -F"\t" '
  $2~/2017/ && $10~/Albuquerque/ {list[$7]++}
  END{
    printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
    for(nama in list){
      printf("%s\n",nama)
    }
    printf("\n")
  }
' /home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
```
Penjelasan :
* Karena menggunakan awk, maka pertama - tama perlu menulis "awk" dan dideklarasikan *Field Separatornya* yaitu tab.
* Pertama-tama, mencari baris yang mengandung kata 2017 pada kolom 2 ($2) yaitu *Order ID* dan mencari kata Albuquerque pada kolom 10 ($10) yaitu *City*, kemudian jika sudah ketemu, maka kolom 7 ($7) yaitu nama customer dijadikan *index* dari *array*: list dan di *increment*.
* *Array* digunakan pada soal ini agar menghindari duplikasi.
* Kemudian untuk mengakses *array* list, menggunakan *looping for* dan isinya untuk mencetak *index* dari *array* tersebut berupa nama customer dan hasilnya tanpa adanya duplikasi.
* awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di "/home/rizqi/Downloads/Laporan-TokoShiSop.tsv" dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori "/home/rizqi/hasil.txt" tanpa me-*replace* file hasil yang sudah ada.
### Sub Soal 2c
Pada soal c, Clemong mencari segment customer dan jumlah transaksinya yang paling sedikit.
```shell
awk -F"\t" '
  $8~/Corporate/ || $8~/Home Office/ || $8~/Consumer/ {seglist[$8]++}
  END {
    min=999999;
    segname;
    for(var in seglist){
      if(min > SEGLIST[var]){
        segname=var;
        min=seglist[var];
      }
    }
    printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d Transaksi\n\n",segname,min)
  }
' /home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
```
Penjelasan :
* Karena menggunakan awk, maka pertama - tama perlu menulis "awk" dan dideklarasikan *Field Separatornya* yaitu tab.
* Pertama-tama, mencari baris yang mengandung kata Corporate atau Home Office atau Consumer pada kolom 8 ($8) yaitu *Segment* dan jika ketemu salah satu, maka kolom tersebut akan dijadikan *index* dari *array* seglist dan akan diincrement jika menemukan kata yang sama tiap *index*.
* Pada END, dideklarasikan variabel min untuk menyimpan nilai minimum dari transaksi, dan nilai awalnya adalah 999999 agar jika dibandingkan dengan jumlah transaksi segmen akan langsung terganti.
* Dideklarasikan juga variabel segname untuk menyimpan jenis segmen yang mempunyai jumlah transaksi terkecil.
* Untuk mengakses *array* menggunakan *looping for* dan perintahnya adalah untuk membandingkan nilai variabel min dan isi *array* tiap index (segmen), jika nilai variabel min lebih besar, maka nilainya akan diganti oleh isi dari array tersebut dan nama segmen nya (*index*) akan disimpan ke variabel segname. Dibandingkan terus menerus sampai *index array* terakhir.
* Kemudian mencetak nilai dari segname yang berupa nama segmen dan min yang berupa jumlah transaksi terkecil.
*  awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di "/home/rizqi/Downloads/Laporan-TokoShiSop.tsv" dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori "/home/rizqi/hasil.txt" tanpa me-*replace* file hasil yang sudah ada.
### Sub Soal 2d
Pada soal d, Manis mencari wilayah bagian yang memiliki total keuntungan paling sedikit dan total keuntungan wilayah tersebut.
```shell
awk -F"\t" '
  {
    if(NR>1){
      profitreg[$13]+=$21
    }
  }
  END {
    min=999999;
    regname;
    for(var in profitreg){
      if(min > profitreg[var]){
        min=profitreg[var];
        regname=var;
      }
    }
    printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %d\n",regname,min)
  }
' /home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt   
```
Penjelasan :
* Karena menggunakan awk, maka pertama - tama perlu menulis "awk" dan dideklarasikan *Field Separatornya* yaitu tab.
* Kemudian membuat *array* dengan *index* region untuk menampung jumlah keuntungan (*profit*) tiap region, jika bertemu index yang sama, maka isi array akan ditambahkan oleh kolom 21 ($21) yaitu kolom profit.
* Pada END, dideklarasikan variabel min untuk menyimpan nilai minimum dari keuntungan, dan nilai awalnya adalah 999999 agar jika dibandingkan dengan jumlah keuntungan region akan langsung terganti.
* Dideklarasikan juga variabel regname untuk menyimpan region yang mempunyai jumlah keuntungan terkecil.
* Untuk mengakses *array* menggunakan *looping for* dan perintahnya adalah untuk membandingkan nilai variabel min dan isi *array* tiap index (region), jika nilai variabel min lebih besar, maka nilainya akan diganti oleh isi dari array tersebut dan nama region nya (*index*) akan disimpan ke variabel regname. Dibandingkan terus menerus sampai *index array* terakhir.
* Kemudian mencetak nama region dan total keuntungan terkecil dari region tersebut.
* awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di "/home/rizqi/Downloads/Laporan-TokoShiSop.tsv" dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori "/home/rizqi/hasil.txt" tanpa me-*replace* file hasil yang sudah ada.
### Sub Soal 2e
Membuat script untuk menghasilkan file "hasil.txt" 
```shell
#sub soal 2a
/home/rizqi/Laporan-TokoShiSop.tsv > /home/rizqi/hasil.txt

#sub soal 2b - 2d
/home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
 ```
 Penjelasan :
 * Sudah ada pada sub soal 2a - 2d, dimana hasilnya akan dimasukkan ke dalam file "hasil.txt"
 * Pada sub soal 2a, jika sudah ada file "hasil.txt" maka akan ditimpa
 * Pada sub soal 2b - 2d, jika sudah ada file "hasil.txt" maka akan tidak akan ditimpa dan hasilnya akan ditambahkan di bagian akhir file tersebut.
## No 3
### Sub Soal 3a
```shell
#!/bin/bash

for ((i=1; i<24; i=i+1))
do
    echo -e "i=$i\n"
    wget -O "Kitten_$i.jpg" -o ->> Foto.log https://loremflickr.com/320/240/kitten
done
```
Pada tahap pertama kode soal3a.sh ini akan didownload gambar random kucing sebnayak 23 gambar. Pada proses ini masih tidak diperdulikan apabila ada yang gambar yang sama.
```shell
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
```
Selanjutnya, akan dicari satu persatu file yang identik atau sama. Metode pencarian file ini seperti bubble sort. Contoh file "Kitten_1" akan dicocokkan dengan dengan file gambar lainnya apakah sama atau tidak. Apabila sama maka salah satu dari file yang sudah ada akan dihapus. Penghapusan file terletak pada bagian 
```shell
  rm -v "$file2"
```
Sedangkan pembandingan 2 gambar apakah sama atau tidak menggunakan command "diff" pada bagian berikut :
```shell
if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
     if diff "$file1" "$file2" > /dev/null; then
```
Kondisi if pertama berjalan apabila $file1 tidak sama degan $file2, file1 dan file2 harus ada.
Setelah melewati tahap pembandingan antar gambar dan penghapusan gambar duplikat, maka nama file akan tidak teratur. Misal "Koleksi_05.jpg" telah dihapus karena sama dengan gambar lain, maka setelah file "Koleksi_04.jpg" akan langsung ke file "Koleksi_06.jpg". Agar penamaan file teratur maka dijalankan kode berikut :
```shell
j=1
for file in *.jpg; do
    if [[ $j -lt 10 ]]; then
        mv "$file" "Koleksi_0$j.jpg"
    else
        mv "$file" "Koleksi_$j.jpg"
    fi
    j=$[$j+1]
done
```
Nama file akan dirubah sehingga semua file akan menjadi urut. 

### Sub Soal 3b
```shell
#!/bin/bash

bash ./soal3a.sh 

tanggal=$(date +'%d-%m-%Y')
mkdir "$tanggal"
mv ./Koleksi_* ./Foto.log "./$tanggal/" 

echo "File has been moved to $tanggal"
```
Pertama, kode soal3a.sh akan di bash. Kemudian dibuatlah directori baru dengan nama tanggal hari ini. Kemudian akan di pindahkan (mv) semua file yang memiliki nama file "Koleksi_" Foto.log ke folder yang baru dibuat tersebut. Maka, file berhasil dipindahkan folder tersebut.

Untuk kode Crontab :
```shell
#!/bin/bash

0 20 1-31/7,2-31/4 * * cd /home/bagus/Documents/soal-shift-sisop-modul-1-D12-2021/soal3/ && bash "soal3b.sh"
```
Kode soal3b.sh ini akan dijalankan setiap jam 8 malam. Dari tanggal 1-31 setiap 7 hari sekali, dan dari tanggal 2-31 setiap 4 hari sekali. 

### Sub Soal 3c
Di soal 3c ini ada 1 fungsi utama untuk mendownload gambar, cek apakah ada yang sama, rename file ulang, dan dipindahkan ke folder dengan nama "Kelinci_tanggalhariini" atau "Kucing_tanggalhariini". Fungsi di bawah ini merupakan gabungan dari kode soal3a.sh dan kode soal 3b.sh hanya beda dalam penamaan folder.
```shell
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
```
$1 pada kode di atas merupakan argumen URL yang dikirimkan ke fungsi tersebut. Sedangkan $2 adalah argumen "Kucing" atau "Kelinci" yang akan dikirimkan ke fungsi tersebut.

Berikut adalah tahap pertama dalam kode ini :
```shell
n_kucing=$(ls | grep -e "Kucing.*" | wc -l)
n_kelinci=$(ls | grep -e "Kelinci.*" | wc -l)
```
Pada kode di atas, akan dicari jumlah folder kucing dan kelinci yang ada. 'grep -e' ditujukan untuk mencari pencarian dengan menerapkan pattern agar matching atau sesuai. Pattern yang digunakan adalah kata "Kucing" dan "Kelinci". 'wc-l' ditujukan untuk menghitung jumlah folder yang ditemukan berdasarkan paterrnya.

Lalu, masuk ke pemilihan kondisi saat akan mendownload gambar kucing atau kelinci :
```shell
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
fi#kondisi kucing
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
```
Di setiap kondisi akan menuju ke fungsi "download_func" dengan mengirimkan url dan "Kelinci/Kucing". Kondisi pertama berjalan apabila jumlah folder kucing($n_kucing) dan jumlah folder kelinci($n_kelinci) sama. Dalam artian, yang didownload kembali adalah gambar kucing. Kondisi kedua berjalan apabila jumlah folder kucing($n_kucing) tidak samaa dengan jumlah folder kelinci($n_kelinci). Dalam artian jumlah folder Kucing lebih banyak daripada jumlah folder Kelinci. Sehingga yang didownload adalah gambar kelinci.


### Sub Soal 3d
```shell
#!/bin/bash

Password=$(date +"%m%d%Y")
zip -r -P "$Password" Koleksi.zip ./Kucing_* ./Kelinci_*
```
Code di atas bertujuan untuk membuat zip dengan password tertentu. Password file zip tersebut menggunakan tanggal pada saat pembuatan zip itu juga. Setelah melakukan zip, file dan folder aslinya tidak akan hilang karena tidak menggunakan remove. Output berupa file "Koleksi.zip" dengan source seluruh folder Kucing dan Kelinci yang telah terbentuk.


### Sub Soal 3e
```shell
#!/bin/bash

#proses membuat zip
0 7 * * 1-5 cd /home/bagus/Documents/soal-shift-sisop-modul-1-D12-2021/soal3/ && bash "soal3d.sh"
```
Code di atas akan membuat zip sesuai jadwal yang sudah ditetapkan melalui crontab, setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, akan mengakses folder /home/bagus/soal-shift-sisop-modul-1-D12-2021/soal3/ dan kemudian akan di bash soal3d.sh
```shell
#proses unzip
0 18 * * 1-5 cd /home/bagus/Documents/soal-shift-sisop-modul-1-D12-2021/soal3/ && unzip -P $(date +"%m%d%Y") && rm Koleksi.zip
```
Code di atas akan unzip sesuai jadwal yang sudah ditetapkan melalui crontab, setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, akan mengakses folder /home/bagus/soal-shift-sisop-modul-1-D12-2021/soal3/ dan kemudian akan unzip Koleksi.zip dengan menggunakan password tanggal hari ini, lalu file zip yang awal akan dihapus. 


