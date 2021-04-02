#!/bin/bash

#-------soal1a-------
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

#-------soal1b-------
grep -oP "$regex1" "$input"| sort | uniq -c | sort -n
n_error=$(grep -c 'ERROR' $input)
echo "ERROR_MESSAGE = $n_error"

#-------soal1c-------
echo ERROR
grep -oP "$regex2" <<< "$(grep -oP "ERROR.*" "$input")" | sort -n | uniq -c
echo INFO
grep -oP "$regex2" <<< "$(grep -oP "INFO.*" "$input")" | sort -n | uniq -c

#-------soal1d-------
printf "ERROR,COUNT\n" > "error_message.csv" 
regex4="^ *[0-9]+ \K.*"
grep -oP "$regex1" "$input" | sort | uniq -c | sort -nr | grep -oP "$regex4" | 
while read -r em; do
    count=$(grep "$em" "$input" | wc -l)
    printf "%s,%d\n" "$em" "$count" >> "error_message.csv"
done 

#-------soal1e-------
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex3" <<< "$(grep -oP "ERROR.*" "$input")" | sort | uniq | 
while read -r er; do
    username=$(grep -oP "$regex2" <<< "$er")
    n_per_info=$(grep "$er" <<< "$(grep -oP "INFO.*" "$input")" | wc -l)
    n_per_error=$(grep "$er" <<< "$(grep -oP "ERROR.*" "$input")" | wc -l)
    printf "%s,%d,%d\n" "$username" "$n_per_info" "$n_per_error" >> "user_statistic.csv"
done
