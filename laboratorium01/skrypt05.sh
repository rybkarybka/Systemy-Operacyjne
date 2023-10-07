#!/bin/bash

# wypisywanie argumentow w odwrotnej kolejnosci

if [[ $# != 0 ]]; then
  params=($*)
  for (( i=($#-1); i>=0; i-- )); do
	echo -n "${params[$i]} "
  done
  echo ''
else
  echo 'brak argumentow'
fi
