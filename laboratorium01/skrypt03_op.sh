#!/bin/bash

# Skrypt dla zadanych wartości oblicza potęgę liczby.
# (jedno rozwiązanie operatorem, jedno rozwiązanie pętlą)

if [[ $# == 2 ]]; then
  echo $(( $1 ** $2 )) 
fi
