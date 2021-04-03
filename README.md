# soal-shift-sisop-modul-1-D12-2021
## Anggota Kelompok
| Nama | NRP |
|------|-----|
|Muhammad Bagus Istighfar|05111940000049|
|Rizqi Rifaldi|05111940000068|
|Afdhal Ma'ruf Lukman|05111940007001| 

Keterangan : Afdhal Ma'ruf Lukman ==> tidak ada kontribusi dan komunikasi sama sekali (hilang tanpa kabar)

## Soal No 1
### Sub Soal 1a
Ryujin diminta untuk mengumpulkan informasi dari log aplikasi pada file syslog.log yang berupa jenis log (INFO atau ERROR), pesan log, dan username pada setiap baris lognya dengan menggunakan regex untuk mempermudah pekerjaannya.
Source Code :
```shell
#all INFO or ERROR. Ex : INFO Commented on ticket [#2389] (sri)
regex="(INFO|ERROR)(.*)"
#log message. Ex : Ticket doesn't exist
regex1="(?<=ERROR )(.*)(?=\ )"
#user name. Ex : blossom
regex2="(?<=[(])(.*)(?=[)])"
#user with (). Ex : (blossom)
regex3="(?=[(])(.*)(?<=[)])"
input="/home/bagus/Downloads/syslog.log";
grep -oP "$regex" "$input"
```
Pada soal ini terdapat inisialisasi beberapa regular expression atau biasa dikenal dengan ```regex```. Regex digunakan untuk mengelompokkan suatu kesatuan text menjadi beberapa kolom tabel dengan metode pencarian ```grep```.
* ```Regex utama``` digunakan untuk mengelompokkan semua INFO atau ERROR.
* ```regex1``` digunakan untuk mengelompokkan semua log message ERROR.
* ```regex2``` digunakan untuk mengelompokkan semua username.
* ```regex3``` digunakan untuk mengelompokkan semua username dengan (username).
Semua ini mengacu pada input file yakni ```syslog.log```.

Kemudian, hasil pencarian berdasarkan pengelompokan ini ditampilkan di output terminal. 

Output yang dihasilkan pada soal 1a adalah :

[![1a-1.jpg](https://i.postimg.cc/mD3r8VJQ/1a-1.jpg)](https://postimg.cc/dk1v0Rq1)

[![1a-2.jpg](https://i.postimg.cc/wjtTS9nx/1a-2.jpg)](https://postimg.cc/k2mmSPnL)

Dapat dilihat bahwa output yang muncul adalah informasi dari log aplikasi pada file syslog.log yang berupa jenis log (INFO atau ERROR), pesan log, dan username pada setiap baris lognya

### Sub Soal 1b
Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
Souce Code :
```shell
grep -oP "$regex1" "$input"| sort | uniq -c | sort -n
```
```grep``` ini digunakan untuk menampilkan pengelompokan pada input file berdasarkan ```regex1```. Hasil pengelompokan ini diurutkan berdasarkan waktu log. 
Setelah itu akan terdapat beberapa message log yang sama sehingga disatukan melalui ```uniq -c```. Melalui uniq ini akan dihitung jumlah message log yang sama. Lalu, akan di sort kembali dari jumlah message log terbanyak yang sama. 

```shell
n_error=$(grep -c 'ERROR' $input)
echo "ERROR_MESSAGE = $n_error"
```
```n_error``` untuk mendapatkan jumlah total message log ERROR.
Output yang dihasilkan pada soal 1b ini adalah :

[![1b.jpg](https://i.postimg.cc/mrRJ7w3x/1b.jpg)](https://postimg.cc/cv9FSf5T)

Ketika dijalankan, script akan menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

### Sub Soal 1c
Ryujin harus menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
Source Code :
```shell
echo ERROR
grep -oP "$regex2" <<< "$(grep -oP "ERROR.*" "$input")" | sort -n | uniq -c
echo INFO
grep -oP "$regex2" <<< "$(grep -oP "INFO.*" "$input")" | sort -n | uniq -c
```
Kedua grep ini untuk menampilkan username dan message log berupa ERROR dan INFO. Kemudian ditampilkan jumlah ERROR atau INFO per username dan diurutkan dari alfabet terkecil username.
Output yang dihasilkan pada soal 1c adalah :

[![1c.jpg](https://i.postimg.cc/qB3fVzv5/1c.jpg)](https://postimg.cc/jCt3yqNH)

Pada soal 1c, script akan mengelompokkan username berdasarkan jenis log nya, serta jumlah kemunculannya yang diurutkan dari alfabet terkecil dari username.

### Sub Soal 1d
Semua informasi yang didapatkan pada sub soal 1b dituliskan ke dalam file ```error_message.csv``` dengan header __Error,Count__ yang diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
Source Code :
```shell
printf "ERROR,COUNT\n" > "error_message.csv" 
regex4="^ *[0-9]+ \K.*"
grep -oP "$regex1" "$input" | sort | uniq -c | sort -nr | grep -oP "$regex4" | 
while read -r em; do
    count=$(grep "$em" "$input" | wc -l)
    printf "%s,%d\n" "$em" "$count" >> "error_message.csv"
done 
```

Output dari script 1d adalah :

[![1d.jpg](https://i.postimg.cc/DZGxD4PQ/1d.jpg)](https://postimg.cc/k6nNR4ZD)

Sub soal ini membuat tabel ke file ```error_message.csv``` dengan 2 kolom yaitu ERROR yang merupakan keterangan message log ERROR dan jumlahnya. 
```regex4``` ini untuk menghilangkan jumlah per message log yang akan dimasukkan ke kolom ERROR. Selama membaca data, sekaligus menghitung jumlah
per message log. 

### Sub Soal 1e
Semua informasi yang didapatkan pada poin c ditulis ke dalam file ```user_statistic.csv``` dengan  header __Username,INFO,ERROR__ dan diurutkan berdasarkan username secara ascending.
Source Code :
```shell
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex3" <<< "$(grep -oP "$regex" "$input")" | sort | uniq | 
while read -r er; do
    username=$(grep -oP "$regex2" <<< "$er")
    n_per_info=$(grep "$er" <<< "$(grep -oP "INFO.*" "$input")" | wc -l)
    n_per_error=$(grep "$er" <<< "$(grep -oP "ERROR.*" "$input")" | wc -l)
    printf "%s,%d,%d\n" "$username" "$n_per_info" "$n_per_error" >> "user_statistic.csv"
done
```
Output yang dihasilkan pada sub soal 1e adalah:

[![1e.jpg](https://i.postimg.cc/RVgLgTz5/1e.jpg)](https://postimg.cc/vc6nBfB3)

Sub soal ini membuat file ```user_statistic.csv``` dengan isi kolom username, INFO yang merupakan jumlah INFO per username, dan ERROR yang merupakan jumlah
ERROR per user. Data yang dibaca saat while apa yang didapatkan dari hasil grep di atasnya yang mengumpulkan seluruh username yang memiliki INFO atau ERROR. Kemudian di pilah kembali dalam while mana yang ERROR dan mana yang INFO. Lalu jumlah ERROR atau INFO per user dihitung total per usernya.

# Soal No 2
Untuk mengerjakan soal nomor 2, dibutuhkan data Toko Shisop berupa laporan dengan nama ```Laporan-TokoShiSop.tsv```
### Sub Soal 2a
Pada soal 2a, Steven diminta untuk mencari Row ID dan *profit percentage* **terbesar** dari ```Laporan-TokoShisop.tsv```, dan jika lebih dari satu maka RowID yang diambil adalah RowID terbesar.
Source Code :
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
Karena menggunakan awk, maka pertama - tama perlu menulis ```awk``` dan dideklarasikan *Field Separatornya* yaitu tab
```shell
awk -F"\t"
```
Pada bagian Begin, saya mendeklarasikan variabel untuk menyimpan nilai PP terbesar yaitu maxpp dan awalnya nilainya adalah 0.
```shell
BEGIN{
    maxpp=0
  }
```
Pada awalnya, saya tidak menggunakan percabangan 'jika Number of Row (NR) tidak sama dengan 1', tetapi terjadi error yaitu "Division by zero", ternyata hal ini dikarenakan baris pertama adalah string, jadi tidak bisa dimasukkan ke dalam rumus mencari persentase profit. Maka dari itu, untuk menghindari error, saya menggunakan percabangan :
```shell
if(NR!=1)
```
Setelah itu, menghitung nilai PP dengan rumus yang sudah ditentukan, dengan $21 adalah *profit* dan $18 adalah *sales*, kemudian hasilnya disimpan di variabel pp
```shell
pp=$21/($18-$21)*100
```
Setelah menghitung nilai pp, pp kemudian dibandingkan dengan maxpp, dan jika nilai pp pada baris baru nilainya lebih besar dari maxpp yang disimpan, maka nilai maxpp akan diganti dengan nilai pp yang baru, dan RowId pada baris tersebut akan disimpan ke variabel id.
```shell
if(pp>=maxpp){
        maxpp=pp;id=$1
```
Pada bagian End, saya mencetak kalimat "Transaksi terakhir dengan profit percentage terbesar yaitu" dan nilai dari RowID dan maxpp.
```shell
END{
    printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%\n\n",id,maxpp)
  }
```
awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di ```/home/rizqi/Downloads/Laporan-TokoShiSop.tsv``` dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori ```/home/rizqi/hasil.txt```.
```shell
/home/rizqi/Downloads/Laporan-TokoShiSop.tsv > /home/rizqi/hasil.txt
```
### Sub Soal 2b
Pada soal 2b, Clemong mencari nama customer pada transaksi tahun 2017 di Albuquerque.
Source Code :
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
Karena menggunakan awk, maka pertama - tama perlu menulis ```awk``` dan dideklarasikan *Field Separatornya* yaitu tab.
```shell
awk -F"\t"
```
Pertama-tama, mencari baris yang mengandung kata 2017 pada kolom 2 ($2) yaitu *Order ID* dan mencari kata Albuquerque pada kolom 10 ($10) yaitu *City*, kemudian jika sudah ketemu, maka kolom 7 ($7) yaitu nama customer dijadikan *index* dari *array*: list dan di *increment*. Awalnya saya tidak menggunakan array, tetapi ternyata setelah di *print* terjadi duplikasi pada nama customer, maka saya gunakan array untuk menghindari duplikasi.
```shell
$2~/2017/ && $10~/Albuquerque/ {list[$7]++}
```
Kemudian pada bagian END, untuk mengakses *array* list, menggunakan *looping for* dan isinya untuk mencetak *index* dari *array* tersebut berupa nama customer dan hasilnya tanpa adanya duplikasi.
```shell
  END{
    printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
    for(nama in list){
      printf("%s\n",nama)
    }
    printf("\n")
  }
```
awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di ```/home/rizqi/Downloads/Laporan-TokoShiSop.tsv``` dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori ```/home/rizqi/hasil.txt``` tanpa me-*replace* file hasil yang sudah ada.
```shell
/home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
```
### Sub Soal 2c
Pada soal c, Clemong mencari segment customer dan jumlah transaksinya yang paling sedikit.
Source Code :
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
Karena menggunakan awk, maka pertama - tama perlu menulis ```awk``` dan dideklarasikan *Field Separatornya* yaitu tab.
```shell
awk -F"\t"
```
Pertama-tama, mencari baris yang mengandung kata Corporate atau Home Office atau Consumer pada kolom 8 ($8) yaitu *Segment* dan jika ketemu salah satu, maka kolom tersebut akan dijadikan *index* dari *array* seglist dan akan diincrement isinya jika menemukan kata yang sama tiap *index*.
```shell
$8~/Corporate/ || $8~/Home Office/ || $8~/Consumer/ {seglist[$8]++}
```
Pada bagian END, dideklarasikan variabel min untuk menyimpan nilai minimum dari transaksi, dan nilai awalnya adalah 999999 agar jika dibandingkan dengan jumlah transaksi segmen akan langsung terganti. Dideklarasikan juga variabel segname untuk menyimpan jenis segmen yang mempunyai jumlah transaksi terkecil.
```shell
min=999999;
    segname;
```
Untuk mengakses *array* menggunakan *looping for* dan perintahnya adalah untuk membandingkan nilai variabel min dan isi *array* tiap index (segmen), jika nilai variabel min lebih besar, maka nilainya akan diganti oleh isi dari array tersebut dan nama segmen nya (*index*) akan disimpan ke variabel segname. Dibandingkan terus menerus sampai *index array* terakhir.
```shell
for(var in seglist){
      if(min > SEGLIST[var]){
        segname=var;
        min=seglist[var];
      }
```
Kemudian mencetak nilai dari segname yang berupa nama segmen dan min yang berupa jumlah transaksi terkecil.
```shell
printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d Transaksi\n\n",segname,min)
```
awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di ```/home/rizqi/Downloads/Laporan-TokoShiSop.tsv``` dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori ```/home/rizqi/hasil.txt``` tanpa me-*replace* file hasil yang sudah ada.
```shell
/home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
```
### Sub Soal 2d
Pada soal d, Manis mencari wilayah bagian yang memiliki total keuntungan paling sedikit dan total keuntungan wilayah tersebut.
Source Code :
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
Karena menggunakan awk, maka pertama - tama perlu menulis ```awk``` dan dideklarasikan *Field Separatornya* yaitu tab.
```shell
awk -F"\t"
```
Kemudian membuat *array* dengan *index* region untuk menampung jumlah keuntungan (*profit*) tiap region, jika bertemu index yang sama, maka isi array akan ditambahkan oleh kolom 21 ($21) yaitu kolom profit. Saya menggunakan percabangan untuk ```NR > 1``` untuk melewati baris pertama yang berupa judul kolom (string)
```shell
if(NR>1){
      profitreg[$13]+=$21
    }
```
Pada bagian END, dideklarasikan variabel min untuk menyimpan nilai minimum dari keuntungan, dan nilai awalnya adalah 999999 agar jika dibandingkan dengan jumlah keuntungan region akan langsung terganti. Dideklarasikan juga variabel regname untuk menyimpan region yang mempunyai jumlah keuntungan terkecil.
```shell
min=999999;
    regname;
```
Untuk mengakses *array*, menggunakan *looping for* dan perintahnya adalah untuk membandingkan nilai variabel min dan isi *array* tiap index (region), jika nilai variabel min lebih besar, maka nilainya akan diganti oleh isi dari array tersebut dan nama region nya (*index*) akan disimpan ke variabel regname. Dibandingkan terus menerus sampai *index array* terakhir.
```shell
for(var in profitreg){
      if(min > profitreg[var]){
        min=profitreg[var];
        regname=var;
      }
    }
```
Kemudian mencetak nama region dan total keuntungan terkecil dari region tersebut.
```shell
   printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %d\n",regname,min)
```
awk ini menggunakan file Laporan-ShiSop.tsv yang saya letakkan di ```/home/rizqi/Downloads/Laporan-TokoShiSop.tsv``` dan hasilnya akan dimasukkan ke dalam file hasil.txt yang saya buat pada direktori ```/home/rizqi/hasil.txt``` tanpa me-*replace* file hasil yang sudah ada.
```shell
/home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
```
### Sub Soal 2e
Membuat script untuk menghasilkan file ```hasil.txt```
```shell
#sub soal 2a
/home/rizqi/Laporan-TokoShiSop.tsv > /home/rizqi/hasil.txt

#sub soal 2b - 2d
/home/rizqi/Laporan-TokoShiSop.tsv >> /home/rizqi/hasil.txt
 ```
Sudah ada pada sub soal 2a - 2d, dimana hasilnya akan dimasukkan ke dalam file "hasil.txt". Pada sub soal 2a, jika sudah ada file "hasil.txt" maka akan ditimpa dan
pada sub soal 2b - 2d, jika sudah ada file "hasil.txt" maka akan tidak akan ditimpa dan hasilnya akan ditambahkan di bagian akhir file tersebut.

Output dari script tersebut dari soal 2a sampai 2d ada pada file hasil.txt, yang isinya adalah sebagai berikut :
[![1617163189455-2.jpg](https://i.postimg.cc/wTLG0fg4/1617163189455-2.jpg)](https://postimg.cc/svfm2JB5)
## No 3
### Sub Soal 3a
Membuat script untuk mengunduh 23 gambar dari ```https://loremflickr.com/320/240/kitten``` serta menyimpan log-nya ke file ```Foto.log```, kemudian menghapus gambar yang sama dan menyimpan gambar-gambar tersebut dengan nama ```Koleksi_XX``` dengan nomor yang berurutan tanpa ada yang hilang.
```shell
#!/bin/bash

for ((i=1; i<24; i=i+1))
do
    echo -e "i=$i\n"
    wget -O "Kitten_$i.jpg" -o ->> Foto.log https://loremflickr.com/320/240/kitten
done
```
Pada tahap pertama kode soal3a.sh ini akan didownload gambar random kucing sebanyak 23 gambar. Pada proses ini apabila ada gambar yang sama akan diabaikan.
```shell
files="$( find -type f )"
    for file1 in $files; do
        for file2 in $files; do
            # echo "cek $file1 and $file2"
            if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
                if diff "$file1" "$file2" > /dev/null; then
                    #echo "$file1 dan $file2 duplikat"
                    rm -v "$file2"
                fi
            fi
        done
    done
```
Selanjutnya, akan dicari satu persatu file yang identik atau sama. Metode pencarian file ini seperti bubble sort. Contoh file "Kitten_1" akan dicocokkan dengan dengan file gambar lainnya apakah sama atau tidak. Apabila sama maka salah satu dari file yang sudah ada akan dihapus. Penghapusan file terletak pada bagian 
```shell
  rm -v "$file2"
```
Sedangkan pembandingan 2 gambar apakah sama atau tidak menggunakan command ```diff``` pada bagian berikut :
```shell
if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
     if diff "$file1" "$file2" > /dev/null; then
```
Kondisi if pertama berjalan apabila ```$file1``` tidak sama degan ```$file2```, file1 dan file2 harus ada.
Setelah melewati tahap pembandingan antar gambar dan penghapusan gambar duplikat, maka nama file akan tidak teratur. Misal ```Koleksi_05.jpg``` telah dihapus karena sama dengan gambar lain, maka setelah file ```Koleksi_04.jpg``` akan langsung ke file ```Koleksi_06.jpg```. Agar penamaan file teratur maka dijalankan kode berikut :
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

Hasil setelah menjalankan script 3a adalah sebagai berikut :

[![3a.jpg](https://i.postimg.cc/Dyp1ryq7/3a.jpg)](https://postimg.cc/mtMcR4Xn)

Pada script ini, akan mendownload 23 foto dari url ```https://loremflickr.com/320/240/kitten``` dan mencatat lognya ke ```Foto.log``` serta menghapus jika ada foto yang sama dan mengganti namanya menjadi ```Koleksi_XX```. ```XX``` merupakan urutan dari file foto yang telah didownload pada url tersebut. 

### Sub Soal 3b
Menjalankan script sehari sekali pada jam 8 malam untuk tanggal - tanggal tertentu setiap bulan, yaitu tanggal 1 tujuh hari sekali dan dari tanggal 2 empat hari sekali. Gambar yang diunduh serta log-nya akan dipindahkan ke folder dengan nama tanggal unduhannya dengan format ```DD-MM-YYYY```. Source Code :
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

Contoh hasil setelah kita menjalankan script tersebut adalah :

[![3b.jpg](https://i.postimg.cc/XYFXrVLH/3b.jpg)](https://postimg.cc/yD175Cwc)

Semua foto koleksi yag telah didownload dan file log foto akan dipindahkan pada folder dengan nama tanggal unduhannya.

Dan jika folder tersebut dibuka, maka hasilnya adalah :

[![3b-1.jpg](https://i.postimg.cc/Gpm2qkrN/3b-1.jpg)](https://postimg.cc/21gr5L1F)

### Sub Soal 3c
Mengunduh gambar kelinci dari ```https://loremflickr.com/320/240/kitten``` dan mengunduh gambar kelinci dan kucing secara bergantian dan memindahkan foto dan log-nya ke folder dengan awalan ```Kucing_``` untuk kucing dan ```Kelinci_```untuk kelinci.

Di soal 3c ini ada 1 fungsi utama untuk mendownload gambar, cek apakah ada yang sama, rename file ulang, dan dipindahkan ke folder dengan nama ```Kelinci_tanggalhariini``` atau ```Kucing_tanggalhariini```. Fungsi di bawah ini merupakan gabungan dari kode soal3a.sh dan kode soal 3b.sh hanya beda dalam penamaan folder.
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
```$1``` pada kode di atas merupakan argumen URL yang dikirimkan ke fungsi tersebut. Sedangkan ```$2``` adalah argumen "Kucing" atau "Kelinci" yang akan dikirimkan ke fungsi tersebut.

Berikut adalah tahap pertama dalam kode ini :
```shell
n_kucing=$(ls | grep -e "Kucing.*" | wc -l)
n_kelinci=$(ls | grep -e "Kelinci.*" | wc -l)
```
Pada kode di atas, akan dicari jumlah folder kucing dan kelinci yang ada. ```grep -e``` ditujukan untuk mencari pencarian dengan menerapkan pattern agar matching atau sesuai. Pattern yang digunakan adalah kata "Kucing" dan "Kelinci". ```wc-l``` ditujukan untuk menghitung jumlah folder yang ditemukan berdasarkan paterrnya.

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
Di setiap kondisi akan menuju ke fungsi ```download_func``` dengan mengirimkan url dan "Kelinci/Kucing". Kondisi pertama berjalan apabila jumlah folder ```kucing($n_kucing)``` dan jumlah folder ```kelinci($n_kelinci)``` sama. Dalam artian, yang didownload kembali adalah gambar kucing. Kondisi kedua berjalan apabila jumlah folder ```kucing($n_kucing)``` tidak sama dengan jumlah folder ```kelinci($n_kelinci)```. Dalam artian jumlah folder Kucing lebih banyak daripada jumlah folder Kelinci. Sehingga yang didownload adalah gambar kelinci.
Output yang dihasilkan setelah menjalankan script 3c adalah:

[![3c-1.jpg](https://i.postimg.cc/Pqy3YvQ2/3c-1.jpg)](https://postimg.cc/Mccm8T4Q)

Karena dimulai dari kucing terlebih dahulu, maka folder yang ada pertama adalah folder kucing yang diikuti tanggal hari ini.
Dan jika folder tersebut dibuka, isinya adalah sebagai berikut :

[![3c-2.jpg](https://i.postimg.cc/kXWkD4zh/3c-2.jpg)](https://postimg.cc/F7sPB99j)

### Sub Soal 3d
Membuat script untuk memindahkan seluruh folder ke zip yang diberi nama ```Koleksi.zip``` dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format ```MMDDYYYY```. Source Code :
```shell
#!/bin/bash

Password=$(date +"%m%d%Y")
zip -rm -P "$Password" Koleksi.zip ./Kucing_* ./Kelinci_*
```
Code di atas bertujuan untuk membuat zip dengan password tertentu. Password file zip tersebut menggunakan tanggal pada saat pembuatan zip itu juga. Setelah melakukan zip, file dan folder aslinya akan hilang. Output berupa file ```Koleksi.zip``` dengan source seluruh folder Kucing dan Kelinci yang telah terbentuk.
Jika dijalankan, pada terminal akan menampilkan notifikasi bahwa foto akan dimasukkan pada zip, seperti pada gambar berikut :

[![3d-1.jpg](https://i.postimg.cc/3wNSjJfh/3d-1.jpg)](https://postimg.cc/rd6NMcLZ)

Dan setelah selesai, maka folder koleksi dan isinya akan dimasukkan ke zip dengan nama ```Koleksi.zip```

[![3d-2.jpg](https://i.postimg.cc/FRcxGfjM/3d-2.jpg)](https://postimg.cc/S2S8xx1d)

Jika ingin membuka zip tersebut, maka dibutuhkan password berupa tanggal zip terebut dibuat, dengan format ```MMDDYYYY``` seperti contoh berikut :

[![3d-3.jpg](https://i.postimg.cc/t4ZnFKdf/3d-3.jpg)](https://postimg.cc/VJwN8HVB)

### Sub Soal 3e
Membuat koleksinya hanya ter-zip saat waktu kuliah yaitu dari Senin - Jumat pada jam 07.00 - 18.00 dan selain waktu tersebut koleksinya ter-unzip dan file zip akan dihapus (tidak ada sama sekali). Source Code :
```shell
#!/bin/bash

#proses membuat zip
0 7 * * 1-5 cd /home/bagus/Documents/soal-shift-sisop-modul-1-D12-2021/soal3/ && bash "soal3d.sh"
```
Code di atas akan membuat zip sesuai jadwal yang sudah ditetapkan melalui crontab, setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, akan mengakses folder ```/home/bagus/soal-shift-sisop-modul-1-D12-2021/soal3/``` dan kemudian akan di bash soal3d.sh
```shell
#proses unzip
0 18 * * 1-5 cd /home/bagus/Documents/soal-shift-sisop-modul-1-D12-2021/soal3/ && unzip -P $(date +"%m%d%Y") && rm Koleksi.zip
```
Code di atas akan unzip sesuai jadwal yang sudah ditetapkan melalui crontab, setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, akan mengakses folder ```/home/bagus/soal-shift-sisop-modul-1-D12-2021/soal3/``` dan kemudian akan unzip Koleksi.zip dengan menggunakan password tanggal hari ini, lalu file zip yang awal akan dihapus. 


