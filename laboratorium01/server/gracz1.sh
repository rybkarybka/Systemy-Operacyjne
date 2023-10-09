#!/bin/bash

while (( 1==1 )); do

  if [[ -f komenda.txt ]]; then
	value=$( cat komenda.txt 2> error.log)

	if [[ ! -f los1.txt ]] && [[ $value=="start" ]];then
	  num=$(( 1 + RANDOM % 3 ))

	  if (( $num == 1 )); then
		echo "papier" > los1.txt
	  elif (( $num == 2 )); then
		echo "kamien" > los1.txt
	  else
		echo "nozyce" > los1.txt
	  fi

	elif [[ $value ==  "stop" ]]; then
	  echo "Konczenie dzialania gracza 1"
	  rm los1.txt
	  exit 1

	fi
  else
	sleep 0.01
  fi

done
