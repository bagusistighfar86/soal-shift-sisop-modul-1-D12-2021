#!/bin/bash

#-------Soal2a-----------
awk -F"\t" '
BEGIN{maxpp=0}
{
    if(NR!=1){
        pp=($21/($18-$21))*100
    if(pp>=maxpp){
        maxpp=pp;id=$1}
    }
}
END {printf("Transaksi terakhir dengan profit percentage terbesar yaitu  %d dengan persentase %.2f%\n\n",id,maxpp)}
' /home/bagus/Downloads/Laporan-TokoShiSop.tsv > /home/bagus/Documents/Modul1/soal2/hasil.txt


#-------Soal2b-----------
awk -F "\t" '
$2~/2017/ && $10~/Albuquerque/ {list[$7]++}
END{
    printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
    for(nama in list){
        printf("%s\n",nama)}
    printf("\n")
}
' /home/bagus/Downloads/Laporan-TokoShiSop.tsv >> /home/bagus/Documents/Modul1/soal2/hasil.txt


#-------soal2c-----------
awk -F"\t" '
$8~/Corporate/ || $8~/Home Office/ || $8~/Consumer/ {seglist[$8]++}
END {
    min=999999;
    segname;
    for(var in seglist){
        if(min > seglist[var]){
            segname=var;
            min=seglist[var];
        }
    }
    printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d Transaksi\n\n",segname,min)
}
' /home/bagus/Downloads/Laporan-TokoShiSop.tsv >> /home/bagus/Documents/Modul1/soal2/hasil.txt

#--------Soal2d------------
awk -F"\t" '
{
    if(NR>1){profitreg[$13]+=$21}
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
' /home/bagus/Downloads/Laporan-TokoShiSop.tsv >> /home/bagus/Documents/Modul1/soal2/hasil.txt
