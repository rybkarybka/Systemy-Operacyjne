#!/bin/bash
tablica=($@)
uzytkownik=0
komputer=0
for i in  ${tablica[@]}
do
  pkn=$((1 + $RANDOM % 3))
  if (( $pkn == 1))
  then 
    #echo $i 'p'
    if (( $i=='n')); then
      ((uzytkownik++))
    elif (( $i=='k' )); then
      ((komputer++))
    fi
  fi
  if (( $pkn==2 )); then
    #echo $i 'k'
    if (( $i=='p')); then
      ((uzytkownik++))     
    elif (( $i=='n' )); then
      ((komputer++))
    fi
  fi
  if (( $pkn == 3 )); then
    #echo $i 'n'
    if (( $i=='k')); then
      ((uzytkownik++))     
    elif (( $i=='p' )); then
      ((komputer++))
    fi

  fi

done

echo $uzytkownik $komputer






///////////////////


#!/bin/bash

zgadnij=$((1 + $RANDOM % 1000))
#echo $zgadnij
while [ 1=1 ]
do
  read liczba
  if (( $liczba < $zgadnij  ))
  then
    echo 'za mala liczba'
  fi
  if (( $liczba > $zgadnij ))
  then
    echo 'za duza liczba'
  fi
  if (( $liczba == $zgadnij ))
  then
    echo 'gratuluje, wygrales!!'
    exit
  fi
done



