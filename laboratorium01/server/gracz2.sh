#!/bin/bash

while (( 1==1 )); do

  if [[ -f komenda.txt ]]; then
	value=$( cat komenda.txt 2> error.log)

	if [[ ! -f los2.txt ]] && [[ $value=="start" ]];then
	  num=$(( 1 + RANDOM % 3 ))

	  if (( $num == 1 )); then
		echo "papier" > los2.txt
	  elif (( $num == 2 )); then
		echo "kamien" > los2.txt
	  else
		echo "nozyce" > los2.txt
	  fi

	elif [[ $value == "stop" ]]; then
	  echo "Konczenie dzialania gracza 2"
	  rm los2.txt
	  exit 1

	fi
  else
	sleep 0.01
  fi

done
