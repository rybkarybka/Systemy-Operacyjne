#!/bin/bash

# wypisanie n elementow ciagu fibonacciego

if [[ $# == 1 ]];then
  if (( $1 >= 1 ));then
	a=1
	b=1
	for (( i=1;i<=$1;i++  )); do
	  echo -n "$a "
	  temp=$b
	  b=$(($a+$b))
	  a=$temp
	done
	echo ''
  else
	echo "Ciag ma dodatnie elementy"
  fi
else
  echo "Bledna ilosc argumentow"
fi
