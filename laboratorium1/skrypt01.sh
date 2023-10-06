#!/bin/bash

if (( $# == 2 )); then
  if [[ -d "$1" ]]; then
	if (( $2 > 0 )); then
	  find $1 -type f -size +$2c | ls -c -lt | head -2 | tail -1 | awk -F' ' '{print($9)}'
	else
	  echo "$2 musi byc wieksza od 0"
	fi
  else
	echo "$1 nie jest katalogiem"
  fi
else
  echo "Nieprawidlowa liczba argumentow"
fi
