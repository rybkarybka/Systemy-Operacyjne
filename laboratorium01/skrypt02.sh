#!/bin/bash

if (( $# == 2 )); then
  if (( $1 >= $2 )); then
	echo "Min jest rowne lub wieksze niz max"
  else
	roznica=$(($2-$1+1))
	randomNum=$(( $1 + RANDOM % $roznica ))

	#user bedzie mial max 7 prob do zdadniecia
	if (( $roznica < 7 )); then
	  maxProb=$roznica
	else
	  maxProb=7
	fi
	
	#petla, by user mial latwiej
	for (( i=0; i<maxProb; i++)); do
	  echo -n -e "Sprobuj zgadnac liczbe, wylosowana liczba jest z przedzialu $1 - $2\n"
	  read liczba

	  if (( $liczba == $randomNum )); then
		echo -e "Brawo, zgadnales liczbe\nUdalo Ci sie za $i razem\nWylosowana liczba to $randomNum"
		break
	  else
		echo -e "Niestety nie udalo Ci sie zgadnac\n"
		sleep 1
	  fi

	done
  fi
else
  echo "Nieprawidlowa liczba argumentow"
fi
