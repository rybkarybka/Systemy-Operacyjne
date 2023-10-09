#!/bin/bash

# serwer do grania w papier kamien nozyce

if [[ $# != 1 ]]; then
  echo "Bledna liczba argumentow"
  exit
fi

gracz1=0
gracz2=0

for (( i=1; i<=$1; i++ )); do
  
  touch komenda.txt
  echo "start" > komenda.txt

  until [ -f los1.txt ] && [ -f los2.txt ]; do
	sleep 0.01
  done

  rm komenda.txt
  sleep 0.1

  los1=$( cat los1.txt )
  los2=$( cat los2.txt )

  if [[ $los1 == $los2 ]]; then
	echo -e "Gra nr $i: REMIS" >> gra.log

  elif [[ $los1 == "kamien" && $los2 == "nozyce" ]] || [[ $los1 == "nozyce" && $los2 == "papier" ]] || [[ $los1 == "papier" && $los2 == "kamien" ]];then
	gracz1=$(( $gracz1+1 ))
	echo -e "Gra nr $i: Gracz 1 wygral przedmiotem $los1" >> gra.log

  else
	gracz2=$(( $gracz2+1 ))
	echo -e "Gra nr $i: Gracz 2 wygral przedmiotem $los2" >> gra.log
  fi

  rm los1.txt
  rm los2.txt
  sleep 0.1

done

echo ""
if (( $gracz1 > $gracz2 )); then
  echo -e "Gracz 1 wygral"
elif (( $gracz1 < $gracz2 )); then
  echo -e "Gracz 2 wygral"
else
  echo -e "REMIS"
fi

echo -e "Wynik: $gracz1:$gracz2\n"
echo "stop" > komenda.txt

sleep 1

rm komenda.txt

echo "Serwer zakonczyl zywot"
exit 1
